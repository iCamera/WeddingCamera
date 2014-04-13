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
@synthesize choseStampsHash;
@synthesize pageControl;
@synthesize pageSize;
@synthesize categoryTabBar;

#define STAMPCOUNT_PER_PAGE 8.0f
#define CATEGORY_ICON_WIDTH 48
#define CATEGORY_ICON_HEIGHT 48

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
    
    // stampカテゴリ読み込み NOTE: データ構造はあとで。
    [self loadCategories];
    
    [stampListView setDataSource:self];
    [stampListView setDelegate:self];
    
    // 複数選択可
    self.stampListView.allowsMultipleSelection = TRUE;
    self.choseStampsHash = [NSMutableDictionary dictionaryWithCapacity:100];

    // stamp pageing設定
    float stampNum = [self.stamps count];
    self.pageSize = ceilf(stampNum / STAMPCOUNT_PER_PAGE);
    
    int currentPage = 0;
    self.pageControl.numberOfPages = self.pageSize;
    self.pageControl.currentPage = currentPage;
    self.pageControl.userInteractionEnabled = YES;
//    [self.pageControl addTarget:self
//                         action:@selector(changePage:)
//               forControlEvents:UIControlEventValueChanged];

    [self.stampListView setContentSize:CGSizeMake(320 * self.pageSize, self.stampListView.frame.size.height)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.stamps = nil;
}

/// スタンプリスト ///

- (void)loadStamps {
    
    // TODO: 仮
    NSMutableArray *stampImages = [NSMutableArray array];
    for (int i = 1; i <= 10; i++) {
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

// スタンプがスクロールされたとき
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.stampListView.frame.size.width;
    int currentPage = floor((self.stampListView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = currentPage;
}

// スタンプが選択されたときに呼ばれる
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"%d", indexPath.item];
    [self.choseStampsHash setObject:[self.stamps objectAtIndex:indexPath.item] forKey:key];

    NSLog(@"Stamp Select %d-%d-%d",indexPath.section,indexPath.row, indexPath.item);

}
// スタンプが選択解除されたときに呼ばれる
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"%d", indexPath.item];
    if ([self.choseStampsHash objectForKey:key]) {
        [self.choseStampsHash removeObjectForKey:key];
    }
    NSLog(@"Stamp Deselect %d-%d-%d",indexPath.section,indexPath.row, indexPath.item);
}

/// スタンプカテゴリリスト ///

- (void)loadCategories {
    
    int category_num = 4;
    NSString *background_filename = [NSString stringWithFormat:@"categoryButton_background.jpg"];
    NSString *background_filename_on = [NSString stringWithFormat:@"categoryButton_background_on.jpg"];
    
    for (int i = 1; i <= category_num; i++) {
        NSString *filename = [NSString stringWithFormat:@"categoryButton_%d.png", i];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:background_filename] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:background_filename_on] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:filename] forState:UIControlStateNormal];
        button.frame = CGRectMake((i-1)*CATEGORY_ICON_WIDTH,
                                  0,
                                  CATEGORY_ICON_WIDTH,
                                  CATEGORY_ICON_HEIGHT);
        button.tag = i;
        [button addTarget:self action:@selector(didSelectCategoryWithButton:) forControlEvents:UIControlEventTouchDown];
        [self.categoryTabBar addSubview:button];
    }
    { // Shopボタン
        category_num = category_num + 1;
        NSString *filename = [NSString stringWithFormat:@"categoryButton_more.png"];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:background_filename] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:background_filename_on] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:filename] forState:UIControlStateNormal];
        button.frame = CGRectMake((category_num-1)*CATEGORY_ICON_WIDTH,
                                  0,
                                  CATEGORY_ICON_WIDTH,
                                  CATEGORY_ICON_HEIGHT);
        button.tag = 0; // shopボタンのタグは常に0
        [button addTarget:self action:@selector(didSelectCategoryWithButton:) forControlEvents:UIControlEventTouchDown];
        [self.categoryTabBar addSubview:button];
    }
    
    self.categoryTabBar.contentSize = CGSizeMake(category_num * CATEGORY_ICON_WIDTH-1, CATEGORY_ICON_HEIGHT);
}

// スタンプカテゴリが選択されたら呼ばれる
-(void)didSelectCategoryWithButton:(UIButton*)button{

//    NSLog(@"Stamp Clicked %d",button);
}

@end
