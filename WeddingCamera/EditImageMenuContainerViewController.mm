//
//  EditImageMenuContainerViewController.m
//  WeddingCamera
//
//  Created by Rie Ito on 2014/03/16.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "EditImageMenuContainerViewController.h"
#import "StampListViewController.h"
#import "FilterListViewController.h"

#define segueStampListView @"stamp"
#define segueFilterListView @"filter"

@interface EditImageMenuContainerViewController ()

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) StampListViewController *stampListViewController;
@property (strong, nonatomic) FilterListViewController *filterListViewController;
@property (assign, nonatomic) BOOL transitionInProgress;
@property (assign, nonatomic) BOOL isOpen;

@end

@implementation EditImageMenuContainerViewController

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
    
    self.transitionInProgress = FALSE;
    self.isOpen = FALSE;
    self.currentSegueIdentifier = segueFilterListView;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (([segue.identifier isEqualToString:segueStampListView]) && !self.stampListViewController) {
        self.stampListViewController = segue.destinationViewController;
    } else if (([segue.identifier isEqualToString:segueFilterListView]) && !self.filterListViewController) {
        self.filterListViewController = segue.destinationViewController;
    }
    
    if (self.childViewControllers.count > 0) {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:segue.destinationViewController];
    } else {
        [self addChildViewController:segue.destinationViewController];
        UIView* destView = ((UIViewController *)segue.destinationViewController).view;
        destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:destView];
        [segue.destinationViewController didMoveToParentViewController:self];
    }
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = FALSE;
    }];
}

// 0: 何もしない 1: 画面切り替えた
- (int)swapViewControllers:(NSString *)swapViewName
{
    
    if (self.transitionInProgress) {
        return 0;
    }
    if (self.isOpen) {
        self.isOpen = FALSE;
        return 0;
    }

    self.isOpen = TRUE;
    if (![swapViewName isEqualToString:self.currentSegueIdentifier]) {
        self.currentSegueIdentifier = swapViewName;
    }
    self.transitionInProgress = TRUE;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
    return 1;
}

@end