//
//  AppDelegate.h
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/03.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
      __strong NSArray *filters;
}

@property (strong, nonatomic) UIWindow *window;

// フィルタ配列を取得するメソッド。
- (NSArray*)filters;


@end
