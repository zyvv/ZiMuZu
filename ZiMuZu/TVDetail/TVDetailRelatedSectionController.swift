//
//  TVDetailRelatedSectionController.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/22.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

class TVDetailRelatedSectionController: ListSectionController, ListAdapterDataSource {
    
    private var tvs: [TV] = []
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override init() {
        super.init()
        
    }
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        if UI_USER_INTERFACE_IDIOM() == .phone {
            return CGSize(width: width, height: (width - 20)/2.0)
        }
        return CGSize(width: width, height: (width - 20)/3.8)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HomeEmbeddedCollectionViewCell.self,
                                                                for: self,
                                                                at: index) as? HomeEmbeddedCollectionViewCell else {
                                                                    fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    override func didUpdate(to object: Any) {
        tvs = object as! [TV]
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return tvs as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return HomeEmbeddedSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

