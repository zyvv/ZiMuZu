//
//  FavoriteNewsTableViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/18.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class FavoriteNewsTableViewController: UITableViewController {
    
    var dataArray: [FavoriteNews]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        viewConfig()
        //        navigationConfig()
        tableView.register(UINib.init(nibName: "NewsListCell", bundle: nil), forCellReuseIdentifier: "NewsListCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = view.backgroundColor
        requestFavoriteNewsList(1)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath)
        
//        let news: FavoriteNews = (dataArray?[indexPath.section])!
//        cell.newsTitle.text = news.detail?.title
//        cell.newsType.text = news.detail?.type_cn
//        cell.newsIntro.text = news.detail?.intro
//        cell.posterImageView.kf.setImage(with: news.detail?.poster)
//        cell.postDate.text = news.detail?.datelineString
//        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailViewController()
//        vc.news = dataArray?[indexPath.section]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    func requestFavoriteNewsList(_ page: Int) {
        zmzProvider.request(.favlist(page: page, limit: 10, ft: "article")) { result in
            if let newsList = handleResponse(nil, type: [FavoriteNews].self, result: result) {
                if page > 1 {
                    self.dataArray?.append(contentsOf: newsList)
                } else {
                    self.dataArray = newsList
                }
                
                self.tableView.reloadData()
                
            }
        }
    }
    
}
