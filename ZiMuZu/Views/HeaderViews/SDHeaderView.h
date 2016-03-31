//
//  SDHeaderView.h
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/31.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaLayout.h"

//#define kSDHeaderViewCellWidth ((kScreenWidth - 2 * kDLMinimumInteritemSpacing - 2 * kDLCellMargin) / 2.0)
//#define kSDHeaderViewHeight ((kSDHeaderViewCellWidth) * kDLImageAspectRaido + kDLCellTextHeight + 45)

@interface SDHeaderView : UIView

- (void)updateFrame;

@end
