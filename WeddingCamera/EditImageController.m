//
//  EditImageController.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/05.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "EditImageController.h"

@implementation EditImageController {
    __weak IBOutlet UIImage *editImage;
}

@synthesize editImage;
@synthesize editImageView;
@synthesize currentStampView;
@synthesize _isPressStamp;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    editImageView.image = editImage;
    
    // スタンプ画像は最初はセットしない
    currentStampView = NULL;
    
    // 最初はスタンプモードでない
    _isPressStamp = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveImageAction:(id)sender {
    UIImage *image = editImageView.image;
    UIImageWriteToSavedPhotosAlbum(image,NULL,NULL,NULL);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelImageAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
