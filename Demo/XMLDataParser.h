//
//  XMLDataParser.h
//  Demo
//
//  Created by Coco on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyEmployee.h"

@interface XMLDataParser : NSObject<NSXMLParserDelegate> {
    NSMutableArray *mEmployeeList;
    MyEmployee *oneEmployee;
    NSString *currentNodeName;
    NSString *currentNodeValue;
}
@property (nonatomic, retain) NSMutableArray *mEmployeeList;
@property (nonatomic, retain) NSString *currentNodeName,*currentNodeValue;
- (NSArray *)employeeListFromXMLData:(NSData *)data;

@end
