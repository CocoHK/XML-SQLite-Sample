//
//  SQLiteOperation.m
//  Demo
//
//  Created by Coco on 25-5-10.
//  Copyright 2012 Coco. All rights reserved.
//

#import "SQLiteOperation.h"

#define DATABASE_FILE_NAME @"company.sqlite"

@interface SQLiteOperation()

@property (nonatomic, assign) sqlite3 *mDatabase;

#define create _creates
-(BOOL)_creates;
-(NSString*)_getDataSourcePath;

@end

@implementation SQLiteOperation

@synthesize mDatabase;

static SQLiteOperation *mSharedSQLiteOperation;

+ (SQLiteOperation *)shared {
	@synchronized(self) {
		if (mSharedSQLiteOperation == nil) {
			mSharedSQLiteOperation = [[self alloc] init];
			if (![mSharedSQLiteOperation create]) {
				return nil;
			}
		}
	}
	return mSharedSQLiteOperation;
}

- (NSString*)_getDataSourcePath{
	NSArray* fileDictory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);\
	NSString *path =  [[fileDictory objectAtIndex:0] stringByAppendingPathComponent:DATABASE_FILE_NAME];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		if (![[NSFileManager defaultManager] copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_FILE_NAME] toPath:path error:nil]) {
            NSLog(@"Cannot copy database to Documents folder");
            return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_FILE_NAME];
		}
    }
    return path;
}

- (BOOL)openDataBase {
	NSString *databasePath = [mSharedSQLiteOperation _getDataSourcePath];
	if (sqlite3_open([databasePath UTF8String], &mDatabase)!=SQLITE_OK) {
		sqlite3_close(mDatabase);
    }
	return YES;
}

- (BOOL)_creates {
	NSString *databasePath = [mSharedSQLiteOperation _getDataSourcePath];
	if (sqlite3_open([databasePath UTF8String], &mDatabase)!=SQLITE_OK) {
		sqlite3_close(mDatabase);
        
	}
	
    //	NSString *create_table_Sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(ROW INTEGER \
    //								  PRIMARY KEY AUTOINCREMENT,NAME TEXT,AGE TEXT,SEX TEXT,TEL TEXT)",tableName];
    //	
    //	char *errmsg;
    //	if(sqlite3_exec(mDatabase, [create_table_Sql UTF8String], NULL, NULL,&errmsg)!=SQLITE_OK)
    //	{
    //		NSAssert(0,@"create table failed",errmsg);
    //		return NO;
    //	}
	return YES;
}

+ (id)allocWithZone:(NSZone *)zone{
	@synchronized(self)	{
		if (mSharedSQLiteOperation == nil) {
			mSharedSQLiteOperation = [super allocWithZone:zone];
			return mSharedSQLiteOperation;
		}
	}
	return nil;
}

- (void)addEmployee:(MyEmployee *)employee {
    if (employee) {
        if ([self openDataBase]) {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO people VALUES(%d,'%@','%@',%d)",employee.employeeID,employee.name,employee.address,employee.age];
            sqlite3_stmt *statement = nil;
            if(sqlite3_prepare_v2(mDatabase, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
                NSLog(@"Add employee error");
            
            while(sqlite3_step(statement) == SQLITE_DONE){}
            sqlite3_finalize(statement);
            
            sqlite3_close(mDatabase);
        }
    }
}

- (NSArray *)getAllEmployees {
    NSMutableArray *employeesArray = [[NSMutableArray alloc] init];

    if ([self openDataBase]) {
        NSString *select_SQL = [NSString stringWithFormat:@"SELECT * FROM people"];
        
        sqlite3_stmt *query_stmt = nil;
        if (sqlite3_prepare_v2(mDatabase, [select_SQL UTF8String], -1,&query_stmt, nil)==SQLITE_OK) {
            while (sqlite3_step(query_stmt) == SQLITE_ROW) {
                if (sqlite3_column_count(query_stmt) > 0) {
                    
                    int employeeID = (int)sqlite3_column_int(query_stmt, 0);
                    char *name = (char*)sqlite3_column_text(query_stmt, 1);
                    char *address = (char*)sqlite3_column_text(query_stmt, 2);
                    int age = (int)sqlite3_column_int(query_stmt, 3);
                    
                    MyEmployee *employee = [MyEmployee new];
                    
                    employee.employeeID = [NSString stringWithFormat:@"%d",employeeID];
                    if (name != NULL) {
                        employee.name = [NSString stringWithUTF8String:name];
                    }
                    if (address != NULL) {
                        employee.address = [NSString stringWithUTF8String:address];
                    }
                    employee.age = [NSString stringWithFormat:@"%d",age];
                    
                    [employeesArray addObject:employee];
                }
            }
        }
        sqlite3_close(mDatabase);
    }
	return [employeesArray autorelease];
}

- (void)cleanAllData {
    if ([self openDataBase]) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM people"];
        
        sqlite3_stmt *statement = nil;
        if(sqlite3_prepare_v2(mDatabase, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
            NSLog(@"Delete all data error");
        
        sqlite3_step(statement);
        sqlite3_finalize(statement);
        sqlite3_close(mDatabase);
    }
}

@end
