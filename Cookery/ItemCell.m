//
//  ItemCell.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "ItemCell.h"

@interface ItemCell()

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *nameCell;
@property (weak, nonatomic) IBOutlet UILabel *weightCell;

@property (weak, nonatomic) IBOutlet UILabel *priceCell;


@end

@implementation ItemCell

- (void) setNameValue:(NSString *)nameValue {
    _nameValue = nameValue;
    _nameCell.text = nameValue;
}

- (void) setWeightValue:(NSString *)weightValue {
    _weightValue = weightValue;
    _weightCell.text = weightValue;
}

- (void) setPriceValue:(NSString *)priceValue {
    _priceValue = priceValue;
    _priceCell.text = priceValue;
}

- (void) setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        _cellImage.image = image;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
