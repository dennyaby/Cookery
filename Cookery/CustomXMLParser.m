//
//  CustomXMLParser.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "CustomXMLParser.h"
#import "LibraryAPI.h"

@interface CustomXMLParser()

@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (strong, nonatomic) NSMutableDictionary *dictData;
@property (strong, nonatomic) NSMutableDictionary *dictTempDataStorage;
@property (strong, nonatomic) NSString *currentElement;
@property (strong, nonatomic) NSString *currentCategory;

@end

@implementation CustomXMLParser

- (id) init {
    if (self = [super init]) {
        self.dictData = [NSMutableDictionary dictionary];
        [self.dictData setObject: [NSMutableArray array] forKey: @"categories"];
        [self.dictData setObject: [NSMutableArray array] forKey: @"offers"];
        self.retreivedData = [NSDictionary dictionaryWithDictionary: self.dictData];
    }
    return self;
}

- (void) parseData:(NSData *)data {
    self.xmlParser = [[NSXMLParser alloc] initWithData: data];
    self.xmlParser.delegate = self;
    
    [self.xmlParser parse];
}

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"Start");
    self.dictTempDataStorage = [NSMutableDictionary dictionary];
    self.dictData = [NSMutableDictionary dictionary];
    self.currentElement = [NSString string];
    self.currentCategory = [NSString string];
    [self.dictData setObject: [NSMutableArray array] forKey: @"categories"];
    [self.dictData setObject: [NSMutableArray array] forKey: @"offers"];
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"End");
    self.retreivedData = self.dictData;
    [self.feedback parserFinishedParsingDataWithResult: self.dictData];
    //[[NSNotificationCenter defaultCenter] postNotificationName: @"parserEndDocument" object: self userInfo: [NSDictionary dictionaryWithDictionary: dictData]];
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString: @"categories"]) {
        self.currentCategory = @"categories";
        return;
    } else if ([elementName isEqualToString: @"offers"]) {
        self.currentCategory = @"offers";
        return;
    }
    
    if ([self.currentCategory isEqualToString: @"categories"]) {
        if ([elementName isEqualToString: @"category"]) {
            self.currentElement = @"category";
            NSLog(@"%@", attributeDict.allValues.firstObject);
            [self.dictTempDataStorage setObject: attributeDict.allValues.firstObject forKey: @"id"]; return;
        }
    } else if ([self.currentCategory isEqualToString: @"offers"]) {
        
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([self.currentElement isEqualToString: @"category"]) {
        [self.dictTempDataStorage setObject:string forKey: @"name"];
    }
}


- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString: @"category"]) {
        [self.dictData[@"categories"] addObject: [self.dictTempDataStorage copy]];
        [self.dictTempDataStorage removeAllObjects];
        self.currentElement = @"";
        return;
    }
    if ([elementName isEqualToString: @"categories"]) {
        self.currentCategory = @"";
    } else if ([elementName isEqualToString: @"offers"]) {
        self.currentCategory = @"";
    }
}


@end
