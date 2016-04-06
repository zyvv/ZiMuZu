//
//  ZMZHelper.h
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/31.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DramaCellLayoutType) {
    DramaCellLayoutTypeVertical = 0,
    DramaCellLayoutTypeHorizontal,
};

@interface ZMZHelper : NSObject

+ (CGSize)dramaCellSizeWithType:(DramaCellLayoutType)dramaCellLayoutType;

@end
