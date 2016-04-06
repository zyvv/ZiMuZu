//
//  ZMZHelper.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/31.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import "ZMZHelper.h"
#import "DramaLayout.h"

@implementation ZMZHelper

+ (CGSize)dramaCellSizeWithType:(DramaCellLayoutType)dramaCellLayoutType {
    CGFloat width = 0;
    if (dramaCellLayoutType == DramaCellLayoutTypeVertical) {
        width = ((kScreenWidth - 2 * kDLMinimumInteritemSpacing - 2 * kDLCellMargin) / 2);
    } else {
        width = ((kScreenWidth - 3 * kDLMinimumInteritemSpacing) / 2);
    }
    return CGSizeMake(width, (width * kDLImageAspectRaido + kDLCellTextHeight));
}

@end
