//
//  NewsListLayout.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/8.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class NewsListLayout: UICollectionViewFlowLayout {
    
    var cache: [UICollectionViewLayoutAttributes]
    var column: Int {
        get {
            if UI_USER_INTERFACE_IDIOM() == .phone {
                return 1;
            }
            return 2;
        }
    }
    
    var layoutPadding: CGFloat {
        get {
            if UI_USER_INTERFACE_IDIOM() == .phone {
                return 0.0;
            }
            return self.sectionInset.left;
        }
    }
    
    
    
    override init() {
        self.cache = []
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        cache.removeAll()
        let itemCount: Int = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        var index = 0
        let collectionViewWidth = self.collectionView?.frame.size.width ?? 0.0
        let itemWidth = (collectionViewWidth - self.layoutPadding * 2.0 - self.minimumInteritemSpacing * CGFloat(self.column - 1)) / CGFloat(self.column)
        var currentColumnIndex = 0
        var currentLine = 0
        while itemCount > index {
            let itemLeft = self.layoutPadding + (itemWidth + self.minimumInteritemSpacing) * CGFloat(currentColumnIndex)
            let itemTop = self.sectionInset.top + (self.itemSize.height + self.minimumLineSpacing) * CGFloat(currentLine)
            let itemFrame = CGRect(x: itemLeft, y: itemTop, width: itemWidth, height: self.itemSize.height)
            let attributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
            attributes.frame = itemFrame
            if self.column == currentColumnIndex {
                currentColumnIndex = 0
                currentLine += 1
            } else {
                currentColumnIndex += 1
            }
        
            index += 1
        }
    }
    
    override var collectionViewContentSize: CGSize {
        guard let lastAttributes = self.cache.last else {
            return CGSize()
        }
        return CGSize(width: lastAttributes.frame.size.width, height: lastAttributes.frame.maxY + self.sectionInset.bottom)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes]? = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes?.append(attributes)
            }
        }
        return layoutAttributes
    }
}
