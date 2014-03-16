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
#import "EditImageMenuContainerViewController.h"

@implementation EditImageController {
    __strong IBOutlet UIImage *editImage;
}

@synthesize editImageView;
@synthesize editImage;

@synthesize editImageMenuContainerViewControlelr;
@synthesize stampListViewController;
@synthesize isPressStamp;
@synthesize undoStack;
@synthesize redoStack;

@synthesize filter;
@synthesize editToolBar;

- (void)viewDidLoad
{
   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 選択した画像を設定
    self.editImageView.image = editImage;
    self.containerView.hidden = TRUE;
    
    // スタンプ
    isPressStamp = FALSE;
    
    // redo, undo
    undoStack = [NSMutableArray array];
    redoStack = [NSMutableArray array];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)redoAction:(id)sender {
    // redoスタックからパスを取り出しundoスタックに追加
    UIImageView *redoImageView = self.redoStack.lastObject;
    
    if (redoImageView) {
        [self.redoStack removeLastObject];
        [self.undoStack addObject:redoImageView];
    
        // subview追加
        [self.editImageView addSubview:redoImageView];
    }
}

- (IBAction)undoAction:(id)sender {
    // undoスタックからパスを取り出しredoスタックに追加
    UIImageView *undoImageView = self.undoStack.lastObject;
    
    if (undoImageView) {
        [self.undoStack removeLastObject];
        [self.redoStack addObject:undoImageView];
        
        // subview削除
        [undoImageView removeFromSuperview];
    }

}

- (IBAction)saveImageAction:(id)sender {
    // jpgとして保存
    UIImage *saveImage = [self _composed];
    UIImageWriteToSavedPhotosAlbum(saveImage,NULL,NULL,NULL);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelImageAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.editImageMenuContainerViewControlelr = segue.destinationViewController;
    }
}
// スタンプを選択するViewをaddする
- (IBAction)chooseStampAction:(id)sender {

    int swapResult = [self.editImageMenuContainerViewControlelr swapViewControllers:@"stamp"];

    if (swapResult) {
        self.containerView.hidden = FALSE;
        self.isPressStamp = TRUE;
    } else {
        self.containerView.hidden = TRUE;
        self.isPressStamp = TRUE;
    }
    
}

// フィルターを選択
- (IBAction)chooseFilterAction:(id)sender {

    int swapResult = [self.editImageMenuContainerViewControlelr swapViewControllers:@"filter"];
    if (swapResult) {
        self.containerView.hidden = FALSE;
    } else {
        self.containerView.hidden = TRUE;
    }
    
    return; // TODO: あとで消す
    CGImageRef inImage = editImageView.image.CGImage;
    if (filter == nil) {
        // TODO: とりあえずフィルタ実行しちゃう
        self.filter = [ ((AppDelegate*)[UIApplication sharedApplication].delegate).filters objectAtIndex:2];
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
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    float x = touchPoint.x;    // X座標
    float y = touchPoint.y;    // Y座標

    NSLog(@"Clicked x:%f y:%f", x, y);
    if (isPressStamp) {
        
        [self _addStamp:&touchPoint];
        self.isPressStamp = FALSE;
        
        // TODO: アニメーション
        self.containerView.hidden = TRUE;
    }
}


- (void)_addStamp:(CGPoint*)point {
    
    for (int i = 0; i < stampListViewController.choseStamps.count; i++) {

        // TODO: タッチした場所を初期配置とする
        UIImageView *stampImageView = [[UIImageView alloc] initWithImage: stampListViewController.choseStamps[i]];
        [self.editImageView addSubview:stampImageView];
        [self.undoStack addObject:stampImageView];
        
    }
    
    stampListViewController.choseStamps = [NSMutableArray array];
    
}


// 元画像とスタンプ画像を合成する
- (UIImage *)_composed {
    
    CGSize imageSize = editImageView.image.size;
    
    UIGraphicsBeginImageContext(imageSize);
    
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = imageSize;
    [editImageView.image drawInRect:rect];
    
    for (int i = 0; i < self.undoStack.count; i++) {
        
        UIImageView *stampImageView = self.undoStack[i];
        
        //重ね合わせる画像を描画
        rect.origin = stampImageView.frame.origin;
        rect.size = stampImageView.frame.size;
        [stampImageView.image drawInRect:rect];
        
    }
    
    UIImage* composedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return composedImage;
}


@end
