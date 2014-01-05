//
//  CollectionCell.h
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/06.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell {
     IBOutlet UIImageView *imageView;
}

- (void)setImage:(UIImage *)image;

@end
