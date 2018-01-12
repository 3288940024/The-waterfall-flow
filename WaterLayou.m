//
//  WaterLayou.m
//  瀑布流
//
//  Created by 杨英俊 on 18-1-10.
//  Copyright © 2018年 杨英俊. All rights reserved.
//

#import "WaterLayou.h"

static const NSInteger count = 3;
static const CGFloat rowmagin = 10;
static const CGFloat columnmagin = 10;
static const UIEdgeInsets edge = {10,10,10,10};

@interface WaterLayou ()
/** 存放每个item的属性数组 */
@property (nonatomic,strong) NSMutableArray *array;
/** 存放最短高度的数组 */
@property (nonatomic,strong) NSMutableArray *minheight;
/** 内容的高度 */
@property (nonatomic,assign) CGFloat contentH;

@end

@implementation WaterLayou

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (NSMutableArray *)minheight {
    if (!_minheight) {
        _minheight = [NSMutableArray array];
    }
    return _minheight;
}


// 准备布局
- (void)prepareLayout {
    [super prepareLayout];
    
    // 清除之前计算的所有高度
    [self.minheight removeAllObjects];
    //给数组初始化值，防止数组越界
    for (NSInteger i = 0; i < count; i++) {
        [self.minheight addObject:@(edge.top)];
    }
    
    // 清除之前所有的布局属性
    [self.array removeAllObjects];
    
    // 1.创建每个item的属性
    // 获取第0section的item个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    // for循环给每个item创建属性
    for (int i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        // 将属性加入属性数组中
        [self.array addObject:attr];
    }
    
}

// 返回每个item的属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.array;
}

// 设置单个item的属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 常见item属性
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectViewW = self.collectionView.frame.size.width;
    CGFloat w = (collectViewW - edge.left - edge.right - columnmagin * (count - 1)) / count;
    CGFloat h = arc4random()%200 + 50;
    
    // 假如最短的那列为第0列
    NSInteger minColumn = 0;
    // 这里要注意数组越界（一开始数组里面先初始化值）
    CGFloat minColumnHeight = [self.minheight[0] doubleValue]; // 最短那列的高度
    
    // 通过比较获取实际最短的那列高度
    for (NSInteger i=1; i<count; i++) {
        // 获取第i列的高度
        CGFloat columnHeight = [self.minheight[i] doubleValue];
        
        // 比较并找出最短列
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            minColumn = i;
        }
    }
    
    // 获取x、y
    CGFloat x = edge.left + minColumn * (w + columnmagin);
    CGFloat y = minColumnHeight;
    // 判断是否是在第一行，如果不是，就增加行间距
    if (y != edge.top) {
        y += rowmagin;
    }
    
    // 设置frame
    attr.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列
    self.minheight[minColumn] = @(CGRectGetMaxY(attr.frame));
    
    // 记入内容的高度
    CGFloat contentH = [self.minheight[minColumn] doubleValue];
    if (self.contentH < contentH) {
        self.contentH = contentH;
    }

    return attr;
}

// 设置内容的尺寸
- (CGSize)collectionViewContentSize {
    return CGSizeMake(0 , self.contentH + edge.bottom);
}

@end
