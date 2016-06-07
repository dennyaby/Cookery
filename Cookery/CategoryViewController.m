//
//  CategoryViewController.m
//  Cookery
//
//  Created by  Dennya on 08.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "CategoryViewController.h"
#import "ItemCell.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.items);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier: @"itemCell" forIndexPath:indexPath];
    NSDictionary *item = self.items[indexPath.row];
    cell.nameValue = item[@"name"];
    cell.weightValue = item[@"weight"];
    cell.priceValue = item[@"price"];
    
    return cell;
}


@end
