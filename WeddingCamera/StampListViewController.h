//
//  StampListViewController.h
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/20.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StampListViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView *stampListView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *stamps;
@property (nonatomic, strong) NSMutableArray *choseStamps;



@end
