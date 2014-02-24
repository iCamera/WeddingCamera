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

    // 編集画面に画像を渡す
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    editImageViewController.editImage = image;
    UIImage *originimage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGImageRef hoge = image.CGImage; // Quartz 2D data
    CGSize fuga = image.size;
    CGBitmapInfo foo = CGImageGetBitmapInfo(hoge);
    CGImageRef hoge2 = originimage.CGImage; // Quartz 2D data
    CGSize fuga2 = originimage.size;
    CGBitmapInfo foo2 = CGImageGetBitmapInfo(hoge2);

    // TODO: 画像サイズ 640x640にリサイズされてるのかえる
    //NSValue* value = [info objectForKey:UIImagePickerControllerCropRect];
    //CGRect rect = [value CGRectValue];
    
    // original image
    //UIImage* oImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    // cropped image
    //UIImage *cropped =[UIImage imageWithCGImage:imageRef];
    //CGImageRelease(imageRef);
    
    // 撮影画面を非表示にする
    [self dismissViewControllerAnimated:TRUE completion:NULL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
