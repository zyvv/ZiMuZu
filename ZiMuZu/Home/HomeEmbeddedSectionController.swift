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
    
    // 返回电视剧cell的size
    override func sizeForItem(at index: Int) -> CGSize {
        let height = collectionContext?.containerSize.height ?? 0
        if UI_USER_INTERFACE_IDIOM() == .phone {
            return CGSize(width: (height - 27)*(8.0/10.0), height: height)
        }
        return CGSize(width: (height - 50)*(8.0/10.0), height: height)
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
    
    override func didSelectItem(at index: Int) {
        let vc = TVDetailViewController()
        vc.tv = tv
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

final class HomeEmbeddedCollectionViewCell: UICollectionViewCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.frame
    }
}
