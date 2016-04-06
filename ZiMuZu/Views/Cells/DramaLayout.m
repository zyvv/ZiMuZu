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
//    self.minimumInteritemSpacing = kDLMinimumInteritemSpacing;
//    self.minimumLineSpacing = kDLMinimumLineSpacing;
    self.sectionInset = UIEdgeInsetsMake(1, kDLCellMargin, 1, kDLCellMargin);
    self.itemSize = CGSizeMake([ZMZHelper dramaCellSizeWithType:DramaCellLayoutTypeHorizontal].width, [ZMZHelper dramaCellSizeWithType:DramaCellLayoutTypeHorizontal].height - 2);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return self;
}

@end
