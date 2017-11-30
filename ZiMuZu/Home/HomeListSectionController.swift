//
//  HomeListSectionController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

class HomeListSectionController: ListSectionController, ListAdapterDataSource {
    private var tvs: HomeSectionList = HomeSectionList(list: [], title: "", handle: "")
    
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        return CGSize(width: width, height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "HomeListCell", bundle: nil, for: self, at: index) as? HomeListCell else {
            fatalError()
        }
        if let tv:TV = tvs.list.first as? TV {
            cell.tvImageView.kf.setImage(with: tv.poster)
        }
        cell.nameLabel.text = tvs.title
        return cell
    }
    
    override func didUpdate(to object: Any) {
        tvs = object as! HomeSectionList
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return tvs.list as! [ListDiffable]
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return HomeEmbeddedSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    override func didSelectItem(at index: Int) {
        let vc = TVListViewController(style: .plain)
        vc.dataArray = tvs.list as? [TV]
        vc.title = tvs.title
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
