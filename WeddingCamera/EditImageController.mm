//
//  EditImageController.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/05.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "EditImageController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "EditImageMenuContainerViewController.h"

@implementation EditImageController {
    __strong IBOutlet UIImage *editImage;
}

@synthesize editImageView;
@synthesize editImage;
@synthesize scale;

@synthesize editImageMenuContainerViewControlelr;
@synthesize isPressStamp;
@synthesize undoStack;
@synthesize redoStack;

@synthesize filter;

- (void)viewDidLoad
{
   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 選択した画像を設定
    self.editImageView.image = editImage;
    
    // 実際の写真サイズから表示サイズのscaleを取得
    self.scale = self.editImageView.image.size.width / self.editImageView.frame.size.width;
    
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
        // スタンプの中身消す
        self.containerView.hidden = TRUE;
        self.isPressStamp = FALSE;
    }
    
}

// フィルターを選択するViewをaddする
- (IBAction)chooseFilterAction:(id)sender {

    // フィルターリストを表示
    int swapResult = [self.editImageMenuContainerViewControlelr swapViewControllers:@"filter"];
    if (swapResult) {
        self.containerView.hidden = FALSE;
        self.editImageMenuContainerViewControlelr.filterListViewController.delegate = self;
    } else {
        self.containerView.hidden = TRUE;
    }
    
}

// 画像の上のイベントリスナー
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    float x = touchPoint.x;    // X座標
    float y = touchPoint.y;    // Y座標

    NSLog(@"Clicked x:%f y:%f", x, y);
    if (isPressStamp) {
        
        [self _addStamp:&touchPoint];

        [self.editImageMenuContainerViewControlelr swapViewControllers:@"stamp"];
        self.isPressStamp = FALSE;
        self.containerView.hidden = TRUE;
    }
}


- (void)_addStamp:(CGPoint*)point {
    
    // 写真の表示scaleに合わせてスタンプ画像を作る
    CGPoint editImagePoint = editImageView.frame.origin;
    
    NSDictionary *choseStampsHash = self.editImageMenuContainerViewControlelr.stampListViewController.choseStampsHash;
    NSArray *keys = choseStampsHash.allKeys;
    for(int i = 0; i < [keys count]; i++){
        
        
        UIImage *stampImage = [choseStampsHash objectForKey: [keys objectAtIndex:(NSUInteger)i]];
        UIImageView *stampImageView = [[UIImageView alloc] init];
        stampImageView.frame = CGRectMake(
                                          (point->x - editImagePoint.x) / scale,
                                          (point->y - editImagePoint.y) / scale,
                                          stampImage.size.width / scale,
                                          stampImage.size.height / scale);
        stampImageView.image = stampImage;
        [self.editImageView addSubview:stampImageView];
        [self.undoStack addObject:stampImageView];
        
    }
}

// FilterListViewControllerのdelegateメソッド
// TODO: applyFilterボタンが選択されたときに呼ばれたい
- (void)didappliyFilter
{
    NSLog(@"call didappliyFilter");
    CGImageRef inImage = editImageView.image.CGImage;
    if (filter == nil) {
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
        rect.size = stampImageView.image.size;
        [stampImageView.image drawInRect:rect];
        
    }
    
    UIImage* composedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return composedImage;
}


@end
