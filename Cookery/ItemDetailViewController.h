//
//  ItemDetailViewController.h
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailViewController : UIViewController

@property (strong, nonatomic) UIImage *itemImage;
@property (strong, nonatomic) NSString *itemDescription;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *itemWeight;
@property (strong, nonatomic) NSString *itemPrice;

@end
