//
//  HomeCell.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/30.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import "HomeCell.h"
#import "DramaCell.h"
#import "FBShimmeringView.h"

@interface HomeCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation HomeCell
{
    __weak IBOutlet UILabel *_rowTitleLabel;
    __weak IBOutlet UICollectionView *_rowCollectionView;
    __weak IBOutlet FBShimmeringView *_shimmeringView;
    
}

static NSString *cellID = @"DramaCell";

- (void)awakeFromNib {
    
    [_rowCollectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    DramaLayout *layout = [[DramaLayout alloc] init];
    _rowCollectionView.collectionViewLayout = layout;
    _rowCollectionView.delegate = self;
    _rowCollectionView.dataSource = self;
    _rowCollectionView.scrollsToTop = NO;
    
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringOpacity = 0.7;
    _shimmeringView.shimmeringPauseDuration = 10;
    _shimmeringView.contentView = _rowTitleLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRowDataArray:(NSArray *)rowDataArray {
    _rowDataArray = rowDataArray;
    [self setNeedsLayout];
}


- (void)setRowTitle:(NSString *)rowTitle {
    _rowTitle = rowTitle;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _rowTitleLabel.text = _rowTitle;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DramaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(clickHomeCell:)]) {
        [_delegate clickHomeCell:self];
    }
}


@end
