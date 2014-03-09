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

@interface EditImageController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *editImageView;
@property (nonatomic, weak) IBOutlet UIToolbar *editToolBar;

// stamp
@property (nonatomic, strong) IBOutlet StampListViewController *stampListViewController;
@property (nonatomic, assign) BOOL isPressStamp;  // スタンプ貼り付け中かどうか
@property (nonatomic, strong) NSMutableArray *undoStack;
@property (nonatomic, strong) NSMutableArray *redoStack;

// filter
@property (nonatomic,retain) ImageFilterBase *filter;

- (IBAction)saveImageAction:(id)sender;
- (IBAction)cancelImageAction:(id)sender;
- (IBAction)chooseStampAction:(id)sender;
- (IBAction)chooseFilterAction:(id)sender;
- (IBAction)redoAction:(id)sender;
- (IBAction)undoAction:(id)sender;

@end
