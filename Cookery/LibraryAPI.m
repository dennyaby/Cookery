//
//  LibraryAPI.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "LibraryAPI.h"
#import "HTTPClient.h"
#import "Database.h"
#import "CustomXMLParser.h"

@interface LibraryAPI() {
    HTTPClient *httpClient;
    Database *database;
    CustomXMLParser *xmlParser;
}

@end

@implementation LibraryAPI

+ (LibraryAPI *) sharedInstance {
    static LibraryAPI *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    return _sharedInstance;
}

- (id) init {
    if (self = [super init]) {
        httpClient = [[HTTPClient alloc] init];
        database = [[Database alloc] init];
        xmlParser = [[CustomXMLParser alloc] init];
        xmlParser.feedback = self;
    }
    
    return self;
}

- (void) parserFinishedParsingDataWithResult: (NSMutableDictionary *) data {
    NSLog(@"%@", data);
    [[NSNotificationCenter defaultCenter] postNotificationName: @"DataDownloaded" object: self];
}

- (NSDictionary *) getData {
    return xmlParser.retreivedData;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void) parserFinishedDocument: (NSNotification *) notification {
    NSLog(@"%@", notification.userInfo);
    //[database setData: notification.userInfo];
    NSMutableArray *arr = notification.userInfo[@"categories"];
    for (int i = 0; i < arr.count; i++) {
        NSLog(@"ID = %@, NAME = %@", arr[i][@"id"], arr[i][@"name"]);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName: @"dataDownloaded" object: self];
}

- (void) downloadDataFromUrl: (NSURL *) url withCompletionHandler: (void(^)(NSData *data)) completionHandler {
    [httpClient downloadDataFromUrl: url withCompletionHandler: completionHandler];
}

- (void) parseData:(NSData *)data {
    [xmlParser parseData:data];
}



@end
