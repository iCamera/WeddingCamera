//
//  StampListViewController.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/20.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "StampListViewController.h"
#import "EditImageController.h"

@interface StampListViewController ()
@end

@implementation StampListViewController

@synthesize stampListView;
@synthesize stamps;
@synthesize choseStamps;
@synthesize pageControl;

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
    
    // stamp画像読み込み
    [self loadStamps];
    
    [stampListView setDataSource:self];
    [stampListView setDelegate:self];
    
    // 複数選択可
    self.stampListView.allowsMultipleSelection = YES;
    self.choseStamps = [NSMutableArray array];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.stamps = nil;
}

- (void)loadStamps {
    
    // TODO: 仮 とりあえずs1~s14まで読み込む
    NSMutableArray *stampImages = [NSMutableArray array];
    for (int i = 1; i <= 14; i++) {
        NSString *filename = [NSString stringWithFormat:@"s%d.png", i];
        [stampImages addObject:[UIImage imageNamed:filename]];
    }
    self.stamps = stampImages;
    
    // pageing設定
    NSInteger pageSize = 3;    
    self.pageControl.numberOfPages = pageSize;
    self.pageControl.currentPage = 0;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.stamps count];
}

//Method to create cell at index path
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    imageView.image = [self.stamps objectAtIndex:indexPath.item];

    // 選択された表示にする
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor redColor];
    cell.selectedBackgroundView = backgroundView;
    
    return cell;
}



//クリックされたらよばれる
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // choseStampsにストック
    [self.choseStamps addObject:[self.stamps objectAtIndex:indexPath.item]];

    NSLog(@"Clicked %d-%d-%d",indexPath.section,indexPath.row, indexPath.item);

}


@end
