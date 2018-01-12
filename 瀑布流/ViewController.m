//
//  ViewController.m
//  瀑布流
//
//  Created by 杨英俊 on 18-1-10.
//  Copyright © 2018年 杨英俊. All rights reserved.
//

#import "ViewController.h"
#import "WaterLayou.h"

@interface ViewController () <UICollectionViewDataSource>

@end

@implementation ViewController

static NSString *reuseId = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WaterLayou *layou = [[WaterLayou alloc] init];
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layou];
    collect.dataSource = self;
    [self.view addSubview:collect];
    
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseId];
}

#pragma mark ~~~~~~~~~~ CollectionViewDataSource ~~~~~~~~~~
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}


@end
