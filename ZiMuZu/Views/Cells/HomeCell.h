//
//  HomeCell.h
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/30.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaLayout.h"

#define kHomeCellInnerCellWidth ((kScreenWidth - 2 * kDLMinimumInteritemSpacing - 2 * kDLCellMargin) / 2)
#define kHomeCellHeight (kHomeCellInnerCellWidth * kDLImageAspectRaido + kDLCellTextHeight + 45)

@interface HomeCell : UITableViewCell

@property (nonatomic, copy) NSString *rowTitle;

@property (nonatomic, copy) NSArray *rowDataArray;

@end
