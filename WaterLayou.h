//
//  WaterLayou.h
//  瀑布流
//
//  Created by 杨英俊 on 18-1-10.
//  Copyright © 2018年 杨英俊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterLayou;

@protocol WaterDelegate <NSObject>
// 动态获取item的高度
- (CGFloat)waterFlowLayout:(WaterLayou *)waterFlowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@end

@interface WaterLayou : UICollectionViewLayout

/** 代理 */
@property (nonatomic,weak) id <WaterDelegate>waterdelegate;



@end
