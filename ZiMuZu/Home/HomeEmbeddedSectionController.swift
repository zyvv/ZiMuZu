//
//  HomeEmbeddedSectionController.swift
//  ZiMuZu
//
//  Created by vi~ on 2017/8/6.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit
import Kingfisher

class HomeEmbeddedSectionController: ListSectionController {

    private var tv: TV?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = collectionContext?.containerSize.height ?? 0
        return CGSize(width: (height - 27)*0.68, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "TVCell", bundle: nil, for: self, at: index) as? TVCell else {
            fatalError()
        }

        if tv?.cnname != nil {
           cell.cnName.text = tv?.cnname
        } else {
            cell.cnName.text = tv?.title
        }
        cell.poster.kf.setImage(with: tv?.poster)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        tv = object as? TV
    }

}
