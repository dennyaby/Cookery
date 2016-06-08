//
//  ItemCell.h
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (strong, nonatomic) NSString *nameValue;
@property (strong, nonatomic) NSString *weightValue;
@property (strong, nonatomic) NSString *priceValue;
@property (strong, nonatomic) UIImage *image;

@end
