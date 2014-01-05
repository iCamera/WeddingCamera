//
//  ViewController.h
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/03.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)showCameraAction:(id)sender;
- (IBAction)showPhotoAlbumAction:(id)sender;


@end
