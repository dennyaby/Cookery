//
//  CategoryViewController.m
//  Cookery
//
//  Created by  Dennya on 08.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "CategoryViewController.h"
#import "ItemCell.h"
#import "LibraryAPI.h"
#import "ItemDetailViewController.h"

@interface CategoryViewController ()

@property (strong, nonatomic) NSMutableDictionary *images;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [NSMutableDictionary new];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(imageDownloaded:) name: @"ImageDownloaded" object:nil];
    
    for (NSDictionary *dict in self.items) {
        NSURL *url = [NSURL URLWithString: dict[@"picture"]];
        [[LibraryAPI sharedInstance] downloadDataFromUrl: url withCompletionHandler: ^(NSData *data){
            if (data != nil) {
                [[NSNotificationCenter defaultCenter] postNotificationName: @"ImageDownloaded" object: nil userInfo: @{@"image": [data copy], @"url": [url absoluteString]}];
            }
        }];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary    dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,  [UIFont fontWithName:@"FontNAme" size:20], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    self.navigationItem.title = self.categoryName;
}

- (void) imageDownloaded: (NSNotification *) notification {
    UIImage *image = [UIImage imageWithData: notification.userInfo[@"image"]];
    if (image == nil) { return ;}
    NSString *key = notification.userInfo[@"url"];
    [self.images setObject: image forKey: key];
    [self.tableView reloadData];
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
    if ([self.images.allKeys containsObject: item[@"picture"]]) {
        cell.image = [self.images objectForKey: item[@"picture"]];
    } else {
        cell.image = [UIImage imageNamed: @"placeholder"];
    }
    cell.nameValue = item[@"name"];
    cell.weightValue = item[@"weight"];
    cell.priceValue = item[@"price"];
    
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"showItem"]) {
        ItemDetailViewController *itemDetailVC = segue.destinationViewController;
        long selectedRow = [self.tableView indexPathForSelectedRow].row;
        NSDictionary *selectedItem = [self.items objectAtIndex: selectedRow];
        itemDetailVC.itemName = selectedItem[@"name"];
        itemDetailVC.itemPrice = selectedItem[@"price"];
        itemDetailVC.itemWeight = selectedItem[@"weight"];
        itemDetailVC.itemDescription = selectedItem[@"description"];
        if ([self.images.allKeys containsObject: selectedItem[@"picture"]]) {
            itemDetailVC.itemImage = [self.images objectForKey: selectedItem[@"picture"]];
        } else {
            itemDetailVC.itemImage = [UIImage imageNamed: @"placeholder"];
        }
    }
}


@end
