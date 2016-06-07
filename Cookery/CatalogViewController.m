//
//  CatalogViewController.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "CatalogViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "LibraryAPI.h"
#import "CategoryCell.h"

static NSString *urlString = @"http://ufa.farfor.ru/getyml/?key=ukAXxeJYZN";

@interface CatalogViewController ()

@end

@implementation CatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.navigationItem.leftBarButtonItem setTarget: self.revealViewController];
        [self.navigationItem.leftBarButtonItem setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataDownloaded:) name: @"DataDownloaded" object:nil];
    [self downloadCookeryData];
}
- (void) dataDownloaded: (NSNotification *) notification {
    NSLog(@"Downloaded");
    [self.tableView reloadData];
    
}

- (void) downloadCookeryData {
    NSURL *url = [NSURL URLWithString: urlString];
    [[LibraryAPI sharedInstance] downloadDataFromUrl: url withCompletionHandler: ^(NSData *data) {
        if (data != nil) {
            [[LibraryAPI sharedInstance] parseData: data];
        }
    }];
    
}


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [[LibraryAPI sharedInstance] getData][@"categories"];
    NSLog(@"Arr count: %d", arr.count);
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier: @"categoryCell" forIndexPath:indexPath];
    NSArray *arr = [[LibraryAPI sharedInstance] getData][@"categories"];
    cell.descriptionString = arr[indexPath.row][@"name"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
