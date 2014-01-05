//
//  CollectionCell.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/06.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImage:(UIImage *)image
{
    [imageView setImage:image];
}


@end
