//
//  NewsListController.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/14.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import SafariServices
import SnapKit

private let reuseIdentifier = "NewsListCell"

class NewsListController: UICollectionViewController, SFSafariViewControllerDelegate {
    
    typealias RefreshState = (isLoading: Bool, beginTimeInterval: CFTimeInterval)
    
    var dataArray: [News]?
    var refeshState: RefreshState = (false, 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfig()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        self.collectionView?.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.backgroundColor = view.backgroundColor
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(NewsListController.refreshData), for: .valueChanged)
        self.collectionView?.refreshControl = refreshControl

        // Do any additional setup after loading the view.
    }
    
    @objc func refreshData() {
        self.requestNewsList(1)
        //        self.refreshControl?.beginRefreshing()
        
        refeshState = (true, CACurrentMediaTime())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataArray?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsListCell
        let news: News = (dataArray?[indexPath.item])!
        cell.newsTitle.text = news.title
        cell.newsType.text = news.type_cn
        cell.newsIntro.text = news.intro
        cell.posterImageView.kf.setImage(with: news.poster)
        cell.postDate.text = news.datelineString
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let news: News = dataArray![indexPath.item];
        let config: SFSafariViewController.Configuration = SFSafariViewController.Configuration.init()
        config.entersReaderIfAvailable = true
        let url = "http://m.zimuzu.tv/article/\(news.id ?? "")"
        let safariVC = SFSafariViewController(url: URL(string:url)!, configuration: config)
        safariVC.preferredBarTintColor = navigationController?.navigationBar.barTintColor
        safariVC.preferredControlTintColor = .white
        safariVC.delegate = self
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
        return [NewsSaveActivity()]
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func requestNewsList(_ page: Int) {
        if refeshState.isLoading {
            return
        }
        zmzProvider.request(.articleList(page:page)) { result in
            if let newsList = handleResponse(nil, type: [News].self, result: result) {
                if page > 1 {
                    self.dataArray?.append(contentsOf: newsList)
                } else {
                    self.dataArray = newsList
                }
                if CACurrentMediaTime() - self.refeshState.beginTimeInterval < 1.0 {
                    DispatchQueue.global(qos: .default).async {
                        sleep(1)
                        DispatchQueue.main.async {
                            self.refeshState = (false, 0)
                            self.collectionView?.reloadData()
                            self.collectionView?.refreshControl?.endRefreshing()
                        }
                    }
                } else {
                    self.refeshState = (false, 0)
                    self.collectionView?.reloadData()
                    self.collectionView?.refreshControl?.endRefreshing()
                }
            }
        }
    }

}
