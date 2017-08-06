//
//  HomeSectionController.swift
//  ZiMuZu
//
//  Created by vi~ on 2017/8/6.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

final class HomeSectionController: ListSectionController, ListAdapterDataSource {

    private var number: TodayTVs = TodayTVs(tvs: [])

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                    viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()

    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        return CGSize(width: width, height: (width - 20)/2.0)
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
        number = object as! TodayTVs
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return number.tvs
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return HomeEmbeddedSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

