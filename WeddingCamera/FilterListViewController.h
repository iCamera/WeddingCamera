//
//  FilterListViewController.h
//  WeddingCamera
//
//  Created by Rie Ito on 2014/03/16.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterListDelegate <NSObject>

- (void)didappliyFilter;

@end

@interface FilterListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *applyFilter;

// デリゲート先で参照できるようにするためプロパティを定義しておく
@property (nonatomic, assign) id <FilterListDelegate> delegate;

@end
