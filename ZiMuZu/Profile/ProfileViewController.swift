//
//  ProfileViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

final class ProfileSection: NSObject {
    
    enum ProfileCatalog: String {
        case favoriteTV = "收藏的剧集"
        case favoriteNews = "收藏的新闻资讯和影评"
//        case recentlyViewedNews = "最近浏览的新闻资讯和影评"
        case downloadAndWatchHistory = "下载和观看记录"
    }
    
    let catalogTitle: ProfileCatalog
    let childCatalog: [String]?
    
    init(_ catalogTitle: ProfileCatalog, childCatalog: [String]?) {
        self.catalogTitle = catalogTitle
        self.childCatalog = childCatalog
    }
}

extension ProfileSection: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}


class ProfileViewController: UIViewController, ListAdapterDataSource {

    var loginView: LoginView? = nil
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()
    
    let pro = ProfileSection(.favoriteTV, childCatalog: nil)
    
    lazy var data: [ProfileSection] = [ProfileSection(.favoriteTV, childCatalog: nil),
                                       ProfileSection(.favoriteNews, childCatalog: nil),
//                                       ProfileSection(.recentlyViewedNews, childCatalog: nil),
                                       ProfileSection(.downloadAndWatchHistory, childCatalog: ["最近播放", "最近下载"])]
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewConfig()
        self.navigationConfig()
        self.navigationItem.title = "记录"
        

        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UserCenter.sharedInstance.isLogin && loginView == nil {
            loginView = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.last as? LoginView
            loginView?.frame = view.bounds
            view.addSubview(loginView!)
            collectionView.isHidden = true
        } else if UserCenter.sharedInstance.isLogin {
            loginView?.removeFromSuperview()
            loginView = nil
            collectionView.isHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        let obj = object as! ProfileSection
        switch obj.catalogTitle {
        case .favoriteTV, .favoriteNews:
            return ProfileListSectionController()
        case .downloadAndWatchHistory:
            return ProfileListSectionController()
        }
        
    }
        
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
