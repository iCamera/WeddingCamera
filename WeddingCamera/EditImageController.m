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

@synthesize editImage, editImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    editImageView.image = editImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
