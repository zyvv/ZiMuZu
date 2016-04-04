//
//  MoreLayout.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/4/3.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import "MoreLayout.h"

@implementation MoreLayout

- (instancetype)init {
    self = [super init];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(kMoreCellMargin, kMoreMinimumInteritemSpacing, kMoreMinimumInteritemSpacing, kMoreCellMargin);
    CGFloat cellWidth = (kScreenWidth - 3 * kMoreMinimumInteritemSpacing) / 2;
    
    self.itemSize = CGSizeMake(cellWidth, [ZMZHelper dramaCellHeight] - 2);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    return self;
}

@end
