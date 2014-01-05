//
//  StampListViewController.m
//  WeddingCamera
//
//  Created by Rie Ito on 14/01/06.
//  Copyright (c) 2014年 Rie Ito. All rights reserved.
//

#import "StampListViewController.h"
#import "CollectionCell.h"

@interface StampListViewController () {
    NSMutableArray *_objects;
}
@property (nonatomic, strong) NSArray *photos;

@end

@implementation StampListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadDemoData
{
    NSMutableArray *samplePhotos = [NSMutableArray array];
    for (int i = 1; i <= 2; i++) {
        NSString *filename = [NSString stringWithFormat:@"stamp%d.jpg", i];
        [samplePhotos addObject:[UIImage imageNamed:filename]];
    }
    self.photos = @[samplePhotos];
    _objects = samplePhotos;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // サンプルデータの読み込み
    [self loadDemoData];
    
    // ナビゲーションバーの色を変更
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    [cell setImage:[_objects objectAtIndex:indexPath.item]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
//        UIImage *img = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:img];
//    }
}



@end
