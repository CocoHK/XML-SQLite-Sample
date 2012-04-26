//
//  XMLDataParser.m
//  Demo
//
//  Created by Coco on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLDataParser.h"

@implementation XMLDataParser

@synthesize mEmployeeList;
@synthesize currentNodeName,currentNodeValue;

- (NSArray *)employeeListFromXMLData:(NSData *)data {
    self.mEmployeeList = [NSMutableArray array];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    [parser release];
    
    return self.mEmployeeList;
}

- (void)dealloc{
	self.mEmployeeList = nil;
	[super dealloc];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"company"]) {
        //
    }
    else if ([elementName isEqualToString:@"people"]) {
        oneEmployee = [MyEmployee new];
        oneEmployee.employeeID = [attributeDict objectForKey:@"id"];
    }
    else {
        self.currentNodeName = elementName;
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"company"]) {
        //
    }
    else if ([elementName isEqualToString:@"people"]) {
        [self.mEmployeeList addObject:oneEmployee];
        [oneEmployee release];
        oneEmployee = nil;
    }
    else if (self.currentNodeName!= nil &&
             oneEmployee != nil) {
        if ([self.currentNodeName isEqualToString:@"name"]) {
            [oneEmployee setName:self.currentNodeValue];
        }
        else if ([self.currentNodeName isEqualToString:@"address"]) {
            [oneEmployee setAddress:self.currentNodeValue];
        }
        else if ([self.currentNodeName isEqualToString:@"age"]) {
            [oneEmployee setAge:self.currentNodeValue];
        }
        self.currentNodeName = nil;
        self.currentNodeValue = nil;
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    if (self.currentNodeName != nil) {
        if (self.currentNodeValue == nil) {
            self.currentNodeValue = string;
        }
        else {
            self.currentNodeValue = [self.currentNodeValue stringByAppendingString:string];
        }
    }
}

@end
