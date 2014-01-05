//
//  EditImageController.h
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/05.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditImageController : UIViewController

@property (weak, nonatomic) IBOutlet UIImage *editImage;
@property (weak, nonatomic) IBOutlet UIImageView *editImageView;
@property (weak, nonatomic) IBOutlet UIImageView *currentStampView;  // 貼り付け中のスタンプ画像
@property (nonatomic, assign) BOOL _isPressStamp;  // スタンプ貼り付け中かどうか

- (IBAction)saveImageAction:(id)sender;
- (IBAction)cancelImageAction:(id)sender;

@end
