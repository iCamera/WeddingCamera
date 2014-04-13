//
//  EditImageMenuContainerViewController.h
//  WeddingCamera
//
//  Created by Rie Ito on 2014/03/16.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StampListViewController.h"
#import "FilterListViewController.h"

@interface EditImageMenuContainerViewController : UIViewController

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) StampListViewController *stampListViewController;
@property (strong, nonatomic) FilterListViewController *filterListViewController;
@property (assign, nonatomic) BOOL transitionInProgress;
@property (assign, nonatomic) BOOL isOpen;

- (int)swapViewControllers: swapViewName;

@end
