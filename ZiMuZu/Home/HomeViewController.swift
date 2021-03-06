//
//  HomeViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit
import PromiseKit

final class HomeViewController: UIViewController, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()
    
    lazy var data: [HomeSectionList] = []
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewConfig()
        self.navigationConfig()
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationItem.title = "热门"
        collectionView.backgroundColor = UIColor.clear
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        requestAllData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as [ListDiffable]
    }
    
    func requestAllData() {
        
        let group = DispatchGroup()
        group.enter()
        self.requestTVs(group)
        group.enter()
        self.requestTopList(group)
        group.enter()
        self.requestNewsList(group)
        group.notify(queue: DispatchQueue.main){
            print("请求结束")
        }
        print("往下走")

    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        let obj = object as! HomeSectionList
        switch obj.title {
        case "今日更新", "本周热门", "热门新剧":
            return HomeSectionController()
        case "最热日剧排行", "本月电影排行", "电视剧总榜":
            return HomeListSectionController()
        case "新闻资讯和剧评":
            return HomeNewsSectionController()
        default:
            return HomeSectionController()
        }

    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    
    
    func requestTVs(_ group: DispatchGroup?) {
        print("第一个请求开始")
        zmzProvider.request(.tv_schedule()) { result in
            group?.leave()
            print("接收第1个请求")
            let decoder = JSONDecoder()
            decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.todayList]
            let todayList = handleResponse(decoder, type: TVSchedule.self, result: result)
            self.data.append(HomeSectionList(list: todayList?.tvs ?? [], title: "今日更新", handle: today()))
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    func requestTopList(_ group: DispatchGroup?) {
        print("第二个请求开始")
        zmzProvider.request(.top()) { result in
            do {
                if case let .success(response) = result {

                    print("接收第2个请求")
                    group?.leave()
                    let decoder = JSONDecoder()
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.favWeekList]
                    let favWeekList = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(HomeSectionList(list: favWeekList.tvs, title: "本周热门", handle: "全部"))
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.playing]
                    let playing = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(HomeSectionList(list: playing.tvs, title: "热门新剧", handle: "全部"))
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.hotJapanList]
                    let hotJapanList = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(HomeSectionList(list: hotJapanList.tvs, title: "最热日剧排行", handle: ""))
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.movieMonthList]
                    let movieMonthList = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(HomeSectionList(list: movieMonthList.tvs, title: "本月电影排行", handle: ""))
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.tvTotalList]
                    let tvTotalList = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(HomeSectionList(list: tvTotalList.tvs, title: "电视剧总榜", handle: ""))
                    
                    self.adapter.performUpdates(animated: true, completion: nil)
                }
            } catch { }
        }
    }
    
    func requestNewsList(_ group: DispatchGroup?) {
        print("第三个请求开始")
        zmzProvider.request(.articleList(page:1)) { result in
            print("接收第3个请求")
            group?.leave()
            let newsList = handleResponse(nil, type: [News].self, result: result)
            self.data.append(HomeSectionList(list: newsList ?? [], title: "新闻资讯和剧评", handle: "更多"))
            self.adapter.performUpdates(animated: true, completion: nil)
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
