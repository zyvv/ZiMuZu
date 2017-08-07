//
//  HomeNewsEmbeddedSectionController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit
import Kingfisher

class HomeNewsEmbeddedSectionController: ListSectionController {
    private var tvs: TVs?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return tvs?.tvs.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = collectionContext?.containerSize.height ?? 0
        return CGSize(width: (collectionContext?.containerSize.width)! - 0, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "NewsCell", bundle: nil, for: self, at: index) as? NewsCell else {
            fatalError()
        }
        let news = tvs?.tvs[index] as! News
        cell.newsTitle.text = news.title
        cell.newsType.text = news.type_cn
        cell.posterImageView.kf.setImage(with: news.poster)
        cell.postDate.text = news.datelineString
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    override func didUpdate(to object: Any) {
        tvs = object as? TVs
    }

}
