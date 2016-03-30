//
//  DramaLayout.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/30.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import "DramaLayout.h"

@implementation DramaLayout

- (instancetype)init {
    self = [super init];
    self.minimumInteritemSpacing = kDLMinimumInteritemSpacing;
    self.minimumLineSpacing = kDLMinimumLineSpacing;
    self.sectionInset = UIEdgeInsetsMake(0, kDLCellMargin, 0, kDLCellMargin);
    CGFloat cellWidth = (kScreenWidth - 2 * kDLMinimumInteritemSpacing - 2 * kDLCellMargin) / 2;
    self.itemSize = CGSizeMake(cellWidth, cellWidth * kDLImageAspectRaido + kDLCellTextHeight);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return self;
}

@end