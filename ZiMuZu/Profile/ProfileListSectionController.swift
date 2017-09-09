//
//  ProfileListSectionController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/18.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

class ProfileListSectionController: ListSectionController {
    private var profileSections: ProfileSection = ProfileSection(.favoriteNews, childCatalog: nil)
    
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        return adapter
    }()
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        return CGSize(width: width, height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ProfileListCell", bundle: nil, for: self, at: index) as? ProfileListCell else {
            fatalError()
        }
        cell.nameLabel.text = profileSections.catalogTitle.rawValue
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        switch profileSections.catalogTitle {
        case .favoriteTV:
            let vc =  FavoriteTVTableViewController(style: .plain)
            vc.title = profileSections.catalogTitle.rawValue
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        case .favoriteNews:
            let vc = FavoriteNewsTableViewController(style: .plain)
            vc.title = profileSections.catalogTitle.rawValue
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = FavoriteTVTableViewController(style: .plain)
            vc.title = profileSections.catalogTitle.rawValue
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
        //        let vc = TVListViewController(collectionViewLayout: TVListLayout())
        //        vc.dataArray = tvs.list as? [TV]
        //        vc.title = tvs.title
        //        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didUpdate(to object: Any) {
        profileSections = object as! ProfileSection
    }
}
