//
//  ViewController.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/03.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "ViewController.h"
#import "EditImageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showCameraAction:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] == NO) {
            // TODO: 例外処理
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = TRUE;
    [self presentViewController:imagePickerController animated:TRUE completion:NULL];
 
}

- (IBAction)showPhotoAlbumAction:(id)sender {

    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO) {
        // TODO: 例外処理
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = TRUE;
    [self presentViewController:imagePickerController animated:TRUE completion:NULL];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    // 編集画面に遷移
    EditImageController * editImageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditImageController"];
    [self.navigationController pushViewController:editImageViewController animated:YES];

    // TODO: ユーザが切り取った領域にしてから、980px x 980pxにリサイズする
    // オリジナル画像をUIImageとして取得
//    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSValue *value = [info objectForKey:UIImagePickerControllerCropRect];
//    CGRect rect = [value CGRectValue];
//    CGImageRef imageRef = CGImageCreateWithImageInRect(originalImage.CGImage, rect);
//    UIImage *image =[UIImage imageWithCGImage:imageRef];

    // 固定サイズにリサイズ
//    int resize_w = 960;
//    int resize_h = 960;
//    UIGraphicsBeginImageContext(CGSizeMake(resize_w, resize_h));
//    [image drawInRect:CGRectMake(0, 0, resize_w, resize_h)];
//    image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    // 編集画面に画像を渡す
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    editImageViewController.editImage = image;
    
    // 撮影画面を非表示にする
    [self dismissViewControllerAnimated:TRUE completion:NULL];

}

static inline double radians (double degrees) {return degrees * M_PI/180;}
- (UIImage*)cropImage:(UIImage*)sourceImage toRect:(CGRect)rect{
    
	CGFloat targetWidth = sourceImage.size.width;
	CGFloat targetHeight = sourceImage.size.height;
    
	CGImageRef imageRef = [sourceImage CGImage];
	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
	if (bitmapInfo == kCGImageAlphaNone) {
		bitmapInfo = kCGImageAlphaNoneSkipLast;
	}
    
	CGContextRef bitmap;
    
	if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
		bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
	} else {
		bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
	}

    
	if (sourceImage.imageOrientation == UIImageOrientationLeft) {
		CGContextRotateCTM (bitmap, radians(90));
		CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
	} else if (sourceImage.imageOrientation == UIImageOrientationRight) {
		CGContextRotateCTM (bitmap, radians(-90));
		CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
	} else if (sourceImage.imageOrientation == UIImageOrientationUp) {
		// NOTHING
	} else if (sourceImage.imageOrientation == UIImageOrientationDown) {
		CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
		CGContextRotateCTM (bitmap, radians(-180.));
	}
    
	CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    ref = CGImageCreateWithImageInRect(ref, rect);
	UIImage* newImage = [UIImage imageWithCGImage:ref];
    
	CGContextRelease(bitmap);
	CGImageRelease(ref);
    
	return newImage; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
