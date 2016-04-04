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

+ (CGFloat)dramaCellHeightWithType:(DramaCellLayoutType)dramaCellLayoutType {
    if (dramaCellLayoutType == DramaCellLayoutTypeVertical) {
        
    } else {
        
    }
    CGFloat width = ((kScreenWidth - 2 * kDLMinimumInteritemSpacing - 2 * kDLCellMargin) / 2);
    return (width * kDLImageAspectRaido + kDLCellTextHeight);
}

@end
