//
//  HomeSectionController.swift
//  ZiMuZu
//
//  Created by vi~ on 2017/8/6.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

final class HomeSectionController: ListSectionController, ListAdapterDataSource, ListSupplementaryViewSource {

    private var tvs: TVs = TVs(tvs: [], title: "", handle: "")

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
        tvs = object as! TVs
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if tvs.tvs.count > 10 {
            return Array(tvs.tvs[..<10]) as! [ListDiffable]
        }
        return tvs.tvs as! [ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return HomeEmbeddedSectionController()
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
            view.name = tvs.title
            view.handle = tvs.handle
            view.tapHandleButton {
                switch self.tvs.title {
                case "今日更新": break
                default:
                    let vc = TVListViewController(collectionViewLayout: TVListLayout())
                    vc.title = self.tvs.title
                    vc.dataArray = self.tvs.tvs as? [TV]
                    self.viewController?.navigationController?.pushViewController(vc, animated: true)
                }
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

