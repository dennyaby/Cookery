//
//  LibraryAPI.h
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibraryAPI : NSObject

- (void) downloadDataFromUrl: (NSURL *) url withCompletionHandler: (void(^)(NSData *data)) completionHandler;
- (void) parseData:(NSData *)data;
- (NSDictionary *) getData;

+ (LibraryAPI *) sharedInstance;

#pragma mark Feedback

- (void) parserFinishedParsingDataWithResult: (NSMutableDictionary *) data;

@end
