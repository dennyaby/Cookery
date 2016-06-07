//
//  CustomXMLParser.h
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibraryAPI.h"

@interface CustomXMLParser : NSObject<NSXMLParserDelegate>

@property (strong, nonatomic) NSDictionary *retreivedData;
@property (weak, nonatomic) LibraryAPI *feedback;
- (void) parseData:(NSData *)data;


@end
