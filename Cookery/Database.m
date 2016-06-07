//
//  Database.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "Database.h"
#import "LibraryAPI.h"

@interface Database()

@property (strong, nonatomic) NSDictionary *data;

@end

@implementation Database

- (void) setData: (NSDictionary *) data {
    self.data = data;
}

- (NSDictionary *) getData {
    return self.data;
}

@end
