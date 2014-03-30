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
@synthesize pageSize;

#define STAMPCOUNT_PER_PAGE 8.0f

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
    self.stampListView.allowsMultipleSelection = TRUE;
    self.choseStamps = [NSMutableArray array];

    // pageing設定
    float stampNum = [self.stamps count];
    self.pageSize = ceilf(stampNum / STAMPCOUNT_PER_PAGE);
    
    int currentPage = 0;
    self.pageControl.numberOfPages = self.pageSize;
    self.pageControl.currentPage = currentPage;
    self.pageControl.userInteractionEnabled = YES;
    [self.pageControl addTarget:self
                         action:@selector(changePage:)
               forControlEvents:UIControlEventValueChanged];

    [self.stampListView setContentSize:CGSizeMake(320 * self.pageSize, self.stampListView.frame.size.height)];
    
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
    for (int i = 1; i <= 12; i++) {
        NSString *filename = [NSString stringWithFormat:@"s%d.png", i];
        [stampImages addObject:[UIImage imageNamed:filename]];
    }
    self.stamps = stampImages;
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

// スクロールされたとき
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.stampListView.frame.size.width;
    int currentPage = floor((self.stampListView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = currentPage;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.stampListView.frame.size.width;
    NSLog(@"%f", self.stampListView.contentOffset.x);
    self.pageControl.currentPage = self.stampListView.contentOffset.x / pageWidth;
}

//クリックされたらよばれる
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // choseStampsにストック
    [self.choseStamps addObject:[self.stamps objectAtIndex:indexPath.item]];

    NSLog(@"Clicked %d-%d-%d",indexPath.section,indexPath.row, indexPath.item);

}


@end
