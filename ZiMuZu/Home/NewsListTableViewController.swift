//
//  NewsListTableViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/9.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {

    typealias RefreshState = (isLoading: Bool, beginTimeInterval: CFTimeInterval)
    
    var dataArray: [News]?
    var refeshState: RefreshState = (false, 0)
    
    
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
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(NewsListTableViewController.refreshData), for: .valueChanged)
        self.refreshControl = refreshControl
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListCell
        cell.news = dataArray?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let imageCellHeight = (kScreenWidth - 20) * 0.3 * (12/16.0) - 10
        let textCellHeight: CGFloat = 130
        return textCellHeight
    }
    
    
    func requestNewsList(_ page: Int) {
        if refeshState.isLoading {
            return
        }
        zmzProvider.request(.articleList(page:page)) { result in
            do {
                if case let .success(response) = result {
                    let news = try JSONDecoder().decode(NewsList.self, from: response.data)
                    if page > 1 {
                        self.dataArray?.append(contentsOf: news.data)
                    } else {
                        self.dataArray = news.data
                    }
                    
                    if CACurrentMediaTime() - self.refeshState.beginTimeInterval < 1.5 {
                        DispatchQueue.global(qos: .default).async {
                            sleep(1)
                            DispatchQueue.main.async {
                                self.refeshState = (false, 0)
                                self.tableView.reloadData()
                                self.refreshControl?.endRefreshing()
                            }
                        }
                    } else {
                        self.refeshState = (false, 0)
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                    }
                    

                }
                
            } catch {
                print(error)
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
