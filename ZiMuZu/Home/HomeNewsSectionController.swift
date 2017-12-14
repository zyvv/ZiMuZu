//
//  HomeNewsSectionController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

class HomeNewsSectionController: ListSectionController, ListAdapterDataSource, ListSupplementaryViewSource {
    
    private var news: HomeSectionList = HomeSectionList(list: [], title: "", handle: "")
    
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override init() {
        super.init()
        supplementaryViewSource = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        return CGSize(width: width, height: (newsItemWidth)*(9/16.0)+110)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HomeNewsEmbeddedCollectionViewCell.self,
                                                                for: self,
                                                                at: index) as? HomeNewsEmbeddedCollectionViewCell else {
                                                                    fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    override func didUpdate(to object: Any) {
        news = object as! HomeSectionList
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {

        return [news] as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return HomeNewsEmbeddedSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader, UICollectionElementKindSectionFooter]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        if elementKind == UICollectionElementKindSectionHeader {
            guard let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                                 for: self,
                                                                                 nibName: "HomeHeaderView",
                                                                                 bundle: nil,
                                                                                 at: index) as? HomeHeaderView else {
                                                                                    fatalError()
            }
            view.name = news.title
            view.handle = news.handle
            view.tapHandleButton {
                let layout = NewsListLayout()
                layout.minimumLineSpacing = 25
                layout.minimumInteritemSpacing = 25
                layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15)
                layout.itemSize = CGSize(width: 1, height: 160)
                if UI_USER_INTERFACE_IDIOM() == .phone {
                    layout.itemSize = CGSize(width: 1, height: 130)
                }
                
                let vc = NewsListController(collectionViewLayout: layout)
                vc.title = self.news.title
                vc.dataArray = self.news.list as? [News]
                self.viewController?.navigationController?.pushViewController(vc, animated: true)
            }
            return view
        }
        let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, for: self, class:UICollectionViewCell.self, at: index)
        return view!
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        if elementKind == UICollectionElementKindSectionHeader {
            return CGSize(width: collectionContext!.containerSize.width, height: 55)
        }
        return CGSize(width: collectionContext!.containerSize.width, height: 30)
    }
}
