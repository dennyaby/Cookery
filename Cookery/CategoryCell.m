//
//  CategoryCell.m
//  Cookery
//
//  Created by  Dennya on 07.06.16.
//  Copyright © 2016  Dennya. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end

@implementation CategoryCell

- (void) setDescriptionString:(NSString *)descriptionString {
    _descriptionString = descriptionString;
    _descriptionLabel.text = descriptionString;
}

- (void) setImage:(UIImage *)image {
    _image = image;
    _cellImage.image = image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.image = [UIImage imageNamed: @"placeholder"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
