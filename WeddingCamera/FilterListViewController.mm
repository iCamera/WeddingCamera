//
//  FilterListViewController.m
//  WeddingCamera
//
//  Created by Rie Ito on 2014/03/16.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "FilterListViewController.h"

@implementation FilterListViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (IBAction)applyFilter:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didappliyFilter)]) {
        [self.delegate didappliyFilter];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
