//
//  EditImageController.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/05.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "EditImageController.h"
#import "StampListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@implementation EditImageController {
    __strong IBOutlet UIImage *editImage;
}

@synthesize editImage;
@synthesize editImageView;
@synthesize isPressStamp;
@synthesize stampListViewController;
@synthesize filter;
@synthesize editToolBar;

- (void)viewDidLoad
{
   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 選択した画像を設定
    editImageView.image = editImage;
    
    // スタンプ
    stampListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StampListViewController"];
    isPressStamp = FALSE;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveImageAction:(id)sender {
    // jpgとして保存
    UIImage *saveImage = editImageView.image;
    UIImageWriteToSavedPhotosAlbum(saveImage,NULL,NULL,NULL);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelImageAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// スタンプを選択するViewをaddする
- (IBAction)chooseStampAction:(id)sender {
    
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    [stampListViewController.view setFrame: CGRectMake(
                                                       0,
                                                       editToolBar.frame.origin.y,
                                                       screenFrame.size.width,
                                                       floor(screenFrame.size.height*0.4)
                                                       )
    ];
    [self addChildViewController:stampListViewController];
    [stampListViewController didMoveToParentViewController:self];
    [self.view addSubview:stampListViewController.view];
    
    UIView *stampListView = stampListViewController.view;
    
    [UIView
        animateWithDuration:0.3
        animations:^{
            CGFloat originY = screenFrame.size.height - editToolBar.frame.size.height - stampListView.frame.size.height;
            CGRect frame = stampListView.frame;
            frame.origin.y = originY;
            stampListView.frame = frame;
        }
        completion:^(BOOL finished){
        }
    ];
    
    self.isPressStamp = TRUE;

}

// フィルターを選択
- (IBAction)chooseFilterAction:(id)sender {
    CGImageRef inImage = editImage.CGImage;
    
    if (filter == nil) {
        // TODO: とりあえずフィルタ実行しちゃう
        self.filter = [ ((AppDelegate*)[UIApplication sharedApplication].delegate).filters objectAtIndex:2];
        //self.filter.currentValue = [NSNumber numberWithFloat:0];
    }
    
    CGImageRef filteredImage;
    if (filter != nil) {
        // 選択中のフィルタでフィルタ処理を実行
        filteredImage = [filter filterImage:inImage];
    } else {
        filteredImage = CGImageRetain(inImage);
    }

    // CGImageをUIImageに変換
    UIImage* newImage = [UIImage imageWithCGImage:filteredImage];
    editImageView.image = newImage;
    
    CGImageRelease(filteredImage);
    CGImageRelease(inImage);
    
}

// 画像の上のイベントリスナー
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 1.anyObjectメソッドでいずれか1つのタッチを取得
    // 2.locationViewメソッドで対象となるビューのタッチした座標を取得
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    float x = touchPoint.x;    // X座標
    float y = touchPoint.y;    // Y座標

    NSLog(@"Clicked x:%f y:%f", x, y);
    if (isPressStamp) {
        
        [self _addStamp:&touchPoint];

        self.isPressStamp = FALSE;
        
        // TODO: アニメーション
        [stampListViewController.view removeFromSuperview];
    }
}

- (void)_addStamp:(CGPoint*)point {
    
    CGSize imageSize = editImageView.image.size;
    
    UIGraphicsBeginImageContext(imageSize);
    
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = imageSize;
    [editImageView.image drawInRect:rect];
    
    
    for (int i = 0; i < stampListViewController.choseStamps.count; i++) {

        UIImage *stamp = stampListViewController.choseStamps[i];
        
        //重ね合わせる画像を描画
        rect.origin = CGPointMake(point->x, point->y);
        rect.size = stamp.size;
        [stamp drawInRect:rect];
    }
   
    UIImage* shrinkedImage;
    shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    editImageView.image = shrinkedImage;
    
    UIGraphicsEndImageContext();
    
    // 初期化
    stampListViewController.choseStamps = [NSMutableArray array];
    
}

@end
