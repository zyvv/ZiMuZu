//
//  HomeViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit
import SwiftyJSON

final class HomeViewController: UIViewController, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()
    
    lazy var data: [TodayTVs] = []
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewConfig()
        self.navigationConfig()
        self.title = "热门"
        collectionView.backgroundColor = UIColor.clear
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        requestTvS()
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
        // note that each child section controller is designed to handle an Int (or no data)
        let sectionController = ListStackedSectionController(sectionControllers: [
            HomeSectionController(),
            ])
//        sectionController.inset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    
    
    func requestTvS() {
        zmzProvider.request(.tv_schedule()) { result in
            do {
                if case let .success(response) = result {
                    let tvs = try JSONDecoder().decode(TVSchedule.self, from: response.data)
                    self.data.append(TodayTVs(tvs: tvs.data.todayTVs))
                    self.adapter.performUpdates(animated: true, completion: nil)
                }
                
            } catch {
                print(error)
            }
        }
    }
    

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
