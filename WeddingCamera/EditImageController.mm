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
@synthesize currentStampView;
@synthesize filter;


- (void)viewDidLoad
{
   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 選択した画像を設定
    editImageView.image = editImage;
    
    // 最初はスタンプモードでない
    isPressStamp = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TODO: もともとの画像サイズに合わせて保存できるようにする
- (IBAction)saveImageAction:(id)sender {
    UIImage *saveImage = [self captureImage];
    UIImageWriteToSavedPhotosAlbum(saveImage,NULL,NULL,NULL);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelImageAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// スタンプを選択するページに遷移する
- (IBAction)chooseStampAction:(id)sender {
    
    StampListViewController * stampListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StampListViewController"];
    [self.navigationController pushViewController:stampListViewController animated:YES];

}
// フィルターを選択
- (IBAction)chooseFilterAction:(id)sender {
    CGImageRef inImage = editImage.CGImage;
    
    if (filter == nil) {
        // TODO: とりあえずフィルタ実行しちゃう
        self.filter = [ ((AppDelegate*)[UIApplication sharedApplication].delegate).filters objectAtIndex:2];
        self.filter.currentValue = [NSNumber numberWithFloat:200];
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
    CGImageRelease(filteredImage);
    CGImageRelease(inImage);
    
    // メモリリークするっぽい。。。
    self.editImage = newImage;
        
}

// 画像の上のイベントリスナー
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 1.anyObjectメソッドでいずれか1つのタッチを取得
    // 2.locationViewメソッドで対象となるビューのタッチした座標を取得
    CGPoint p = [[touches anyObject] locationInView:self.view];
    float x = p.x;    // X座標
    float y = p.y;    // Y座標

    NSLog(@"Clicked x:%f y:%f", x, y);
    if (isPressStamp) {
        float stampWidth = currentStampView.image.size.width;
        float stampHeight = currentStampView.image.size.height;
        currentStampView.frame = CGRectMake(x - stampWidth, y - stampHeight, stampWidth, stampHeight);
        [self.editImageView addSubview:self.currentStampView];
    }
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