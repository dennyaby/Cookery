//
//  ItemCell.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "ItemCell.h"

@interface ItemCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageCell;
@property (weak, nonatomic) IBOutlet UILabel *nameCell;
@property (weak, nonatomic) IBOutlet UILabel *weightCell;

@property (weak, nonatomic) IBOutlet UILabel *priceCell;


@end

@implementation ItemCell

- (void) setNameValue:(NSString *)nameValue {
    _nameValue = nameValue;
    self.nameCell.text = nameValue;
}

- (void) setWeightValue:(NSString *)weightValue {
    _weightValue = weightValue;
    self.weightCell.text = weightValue;
}

- (void) setPriceValue:(NSString *)priceValue {
    _priceValue = priceValue;
    self.priceCell.text = priceValue;
}

- (void) setImageValue:(UIImage *)imageValue {
    _imageValue = imageValue;
    self.imageCell.image = imageValue;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageValue = [UIImage imageNamed: @"placeholder"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
