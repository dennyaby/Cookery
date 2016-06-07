//
//  HTTPClient.h
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPClient : NSObject

- (void) downloadDataFromUrl: (NSURL *) url withCompletionHandler: (void(^)(NSData *data)) completionHandler;

@end
