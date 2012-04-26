//
//  SQLiteOperation.h
//  cococalorie
//
//  Created by Coco on 12-4-10.
//  Copyright 2012 Coco. All rights reserved.
//

#import "/usr/include/sqlite3.h"
#import "MyEmployee.h"

@interface SQLiteOperation : NSObject {
	sqlite3 *mDatabase;
}

+ (SQLiteOperation *)shared;
- (void)addEmployee:(MyEmployee *)employee;
- (NSArray *)getAllEmployees;
- (void)cleanAllData;
@end
