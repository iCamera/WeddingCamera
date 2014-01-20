//
//  StampListViewController.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/20.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "StampListViewController.h"

@interface StampListViewController ()

@end

@implementation StampListViewController

@synthesize stampListView;
@synthesize stamps;

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
    
    [stampListView setDataSource:self];
    [stampListView setDelegate:self];
    
    // stamp画像読み込み
    [self loadStamps];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.stamps = nil;
}

- (void)loadStamps {
    
    NSMutableArray *stampImages = [NSMutableArray array];
    for (int i = 1; i <= 4; i++) {
        NSString *filename = [NSString stringWithFormat:@"s%d.png", i];
        [stampImages addObject:[UIImage imageNamed:filename]];
    }

    self.stamps = stampImages;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //とりあえずセクションは1つ
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //セクション0には５個
    //return 5;
    return [self.stamps count];
}

//Method to create cell at index path
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    imageView.image = [self.stamps objectAtIndex:indexPath.item];
  
// デバック用
//    UILabel *label = (UILabel *)[cell viewWithTag:2];
//    label.text = [NSString stringWithFormat:@"ラベル%d-%d",indexPath.section,indexPath.row];

    return cell;
}

//クリックされたらよばれる
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Clicked %d-%d-%d",indexPath.section,indexPath.row, indexPath.item);
}


@end
