//
//  EditImageController.h
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/05.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageFilterBase.h"
#import "StampListViewController.h"
#import "EditImageMenuContainerViewController.h"

@interface EditImageController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *editImageView;
@property (nonatomic, strong) IBOutlet UIImage *editImage;
@property (nonatomic, weak) IBOutlet UIToolbar *editToolBar;

@property (nonatomic, strong) IBOutlet EditImageMenuContainerViewController *editImageMenuContainerViewControlelr;

// stamp
@property (nonatomic, strong) IBOutlet StampListViewController *stampListViewController;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@property (nonatomic, assign) BOOL isPressStamp;  // スタンプ貼り付け中かどうか
@property (nonatomic, weak) NSMutableArray *undoStack;
@property (nonatomic, weak) NSMutableArray *redoStack;

// filter
@property (nonatomic,retain) ImageFilterBase *filter;

- (IBAction)saveImageAction:(id)sender;
- (IBAction)cancelImageAction:(id)sender;
- (IBAction)chooseStampAction:(id)sender;
- (IBAction)chooseFilterAction:(id)sender;
- (IBAction)redoAction:(id)sender;
- (IBAction)undoAction:(id)sender;

@end
