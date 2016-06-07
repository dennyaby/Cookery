//
//  HTTPClient.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "HTTPClient.h"
#import "LibraryAPI.h"

@implementation HTTPClient {
    LibraryAPI *feedback;
}

- (void) downloadDataFromUrl:(NSURL *)url withCompletionHandler:(void (^)(NSData *))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: configuration];
    NSURLSessionDataTask *task = [session dataTaskWithURL: url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSInteger httpStatusCode = [(NSHTTPURLResponse *)response statusCode];
            if (httpStatusCode != 200) {
                NSLog(@"HTTP statuc code = %ld", (long)httpStatusCode);
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                completionHandler(data);
            }];
        }
    }];
    
    [task resume];
}


@end
