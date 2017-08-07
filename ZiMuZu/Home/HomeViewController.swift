//
//  HomeViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

final class HomeViewController: UIViewController, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()
    
    lazy var data: [TVs] = []
    
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
        requestTopList()
        requestNewsList()
        
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
        
        let obj = object as! TVs
        switch obj.title {
        case "今日更新":
            return HomeSectionController()
        case "本周热门":
            return HomeSectionController()
        case "热门新剧":
            return HomeSectionController()
        case "最热日剧排行":
            return HomeListSectionController()
        case "本月电影排行":
            return HomeListSectionController()
        case "电视剧总榜":
            return HomeListSectionController()
        case "新闻资讯和剧评":
            return HomeNewsSectionController()
        default:
            return HomeSectionController()
        }

    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    
    
    func requestTvS() {
        zmzProvider.request(.tv_schedule()) { result in
            do {
                if case let .success(response) = result {
                    let decoder = JSONDecoder()
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.todayList]
                    let tvs = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(TVs(tvs: tvs.data.tvs, title: "今日更新", handle: today()))
                    self.adapter.performUpdates(animated: true, completion: nil)
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    func requestTopList() {
        zmzProvider.request(.top()) { result in
            do {
                if case let .success(response) = result {
                    let decoder = JSONDecoder()
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.favWeekList]
                    let favWeekList = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(TVs(tvs: favWeekList.data.tvs, title: "本周热门", handle: "全部"))
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.playing]
                    let playing = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(TVs(tvs: playing.data.tvs, title: "热门新剧", handle: "全部"))
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.hotJapanList]
                    let hotJapanList = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(TVs(tvs: hotJapanList.data.tvs, title: "最热日剧排行", handle: ""))
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.movieMonthList]
                    let movieMonthList = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(TVs(tvs: movieMonthList.data.tvs, title: "本月电影排行", handle: ""))
                    
                    decoder.userInfo = [TVScheduleDataCodingOptions.key: TVScheduleDataCodingOptions.TVScheduleDataType.tvTotalList]
                    let tvTotalList = try decoder.decode(TVSchedule.self, from: response.data)
                    self.data.append(TVs(tvs: tvTotalList.data.tvs, title: "电视剧总榜", handle: ""))
                    
                    self.adapter.performUpdates(animated: true, completion: nil)
                }
            } catch { }
        }
    }
    
    func requestNewsList() {
        zmzProvider.request(.articleList(page:1)) { result in
            do {
                if case let .success(response) = result {
                    let news = try JSONDecoder().decode(NewsList.self, from: response.data)
                    self.data.append(TVs(tvs: news.data, title: "新闻资讯和剧评", handle: "更多"))
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
