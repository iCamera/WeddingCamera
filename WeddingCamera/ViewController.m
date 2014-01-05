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
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = TRUE;
    [self presentViewController:imagePickerController animated:TRUE completion:NULL];
 
}

- (IBAction)showPhotoAlbumAction:(id)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = TRUE;
    [self presentViewController:imagePickerController animated:TRUE completion:NULL];
    
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"chooseImage"]) {
//        EditImageController *editImageViewController = segue.destinationViewController;
//        editImageViewController.imageView = image;
//    }
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    //[self performSegueWithIdentifier:@"chooseImage" sender:self];
    // 編集画面に遷移
    EditImageController * editImageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditImageController"];
    [self.navigationController pushViewController:editImageViewController animated:YES];

    // 編集画面に画像を渡す
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    editImageViewController.editImage = image;
    
    // 撮影画面を非表示にする
    [self dismissViewControllerAnimated:TRUE completion:NULL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
