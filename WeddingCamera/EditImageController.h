//
//  EditImageController.h
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/05.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageFilterBase.h"
#import "EditImageMenuContainerViewController.h"

@interface EditImageController : UIViewController<FilterListDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *editImageView;
@property (nonatomic, strong) IBOutlet UIImage *editImage;
@property float scale;

// footerから選択されて表示するsub view
@property (nonatomic, strong) IBOutlet EditImageMenuContainerViewController *editImageMenuContainerViewControlelr;
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)chooseStampAction:(id)sender;
- (IBAction)chooseFilterAction:(id)sender;

// スタンプ貼り付け中かどうか
@property (nonatomic, assign) BOOL isPressStamp;

// 進む、戻る
@property (nonatomic, strong) NSMutableArray *undoStack;
@property (nonatomic, strong) NSMutableArray *redoStack;
- (IBAction)redoAction:(id)sender;
- (IBAction)undoAction:(id)sender;

// filter
@property (nonatomic,retain) ImageFilterBase *filter;

// 保存・キャンセル
- (IBAction)saveImageAction:(id)sender;
- (IBAction)cancelImageAction:(id)sender;

@end
