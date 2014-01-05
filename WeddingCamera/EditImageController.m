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

@implementation EditImageController {
    __weak IBOutlet UIImage *editImage;
}

@synthesize editImage;
@synthesize editImageView;
@synthesize _isPressStamp;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 選択した画像を設定
    editImageView.image = editImage;
    
    // 最初はスタンプモードでない
    _isPressStamp = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveImageAction:(id)sender {
    UIImage *saveImage = [self captureImage];
    UIImageWriteToSavedPhotosAlbum(saveImage,NULL,NULL,NULL);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelImageAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// あとでシーン追加して画像選択できるようにする
// とりあえず固定の画像を画面にはりつける
- (IBAction)chooseStampAction:(id)sender {
    
    StampListViewController * stampListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StampListViewController"];
    [self.navigationController pushViewController:stampListViewController animated:YES];
    //UIImageView *currentStampView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 64, 64)];
    //currentStampView.image = [UIImage imageNamed:@"stamp1.png"];
    //[self.editImageView addSubview:currentStampView];
}

// キャプチャをとって画像を保存
// 領域を指定して画像を切り抜く
-(UIImage *)captureImage
{
    // 描画領域の設定
    CGSize size = CGSizeMake(editImageView.frame.size.width , editImageView.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // グラフィックスコンテキスト取得
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // コンテキストの位置を切り取り開始位置に合わせる
    CGPoint point = editImageView.frame.origin;
    CGAffineTransform affineMoveLeftTop
    = CGAffineTransformMakeTranslation(
                                       -(int)point.x ,
                                       -(int)point.y );
    CGContextConcatCTM(context , affineMoveLeftTop );
    
    // viewから切り取る
    [(CALayer*)self.view.layer renderInContext:context];
    
    // 切り取った内容をUIImageとして取得
    UIImage *cnvImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // コンテキストの破棄
    UIGraphicsEndImageContext();
    
    return cnvImg;
}

@end
