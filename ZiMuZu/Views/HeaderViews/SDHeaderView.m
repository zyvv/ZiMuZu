//
//  SDHeaderView.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/31.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import "SDHeaderView.h"
#import "DramaCell.h"
#import "DramaLayout.h"
#import "FBShimmeringView.h"

static NSString *cellID = @"DramaCell";

@interface SDHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SDHeaderView
{
    __weak IBOutlet FBShimmeringView *_shimmeringView;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UICollectionView *_todayListCollectionView;
    __weak IBOutlet NSLayoutConstraint *_shimmeringViewHeight;
    
}

- (void)awakeFromNib {
    [_todayListCollectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    DramaLayout *layout = [[DramaLayout alloc] init];
    NSLog(@"错误：collHeight: %.2f, layout.Hight: %.2f", _todayListCollectionView.height, layout.itemSize.height);
    _todayListCollectionView.collectionViewLayout = layout;
    _todayListCollectionView.delegate = self;
    _todayListCollectionView.dataSource = self;
    _todayListCollectionView.scrollsToTop = NO;
    
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringOpacity = 0.7;
    _shimmeringView.shimmeringPauseDuration = 10;
    _shimmeringView.contentView = _titleLabel;

}

- (void)updateFrame {
    [self setNeedsLayout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DramaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
    
}



@end
