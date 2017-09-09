//
//  FavoriteTVTableViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/18.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class FavoriteTVTableViewController: UITableViewController {

    var dataArray: [FavoriteTV]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfig()
        //        navigationConfig()
        tableView.separatorStyle = .none
        tableView.backgroundColor = view.backgroundColor
        tableView.register(UINib.init(nibName: "FavoriteTVCell", bundle: nil), forCellReuseIdentifier: "FavoriteTVCell")
        
        requestFavoriteTVList(1)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTVCell", for: indexPath) as? FavoriteTVCell else {
            fatalError()
        }

        let favoriteTV: FavoriteTV = dataArray![indexPath.section] as FavoriteTV
        cell.posterImageView.kf.setImage(with: favoriteTV.detail?.poster_b)
        cell.typeLabel.text = favoriteTV.detail?.channel_cn
        cell.nameLabel.text = favoriteTV.detail?.cnname
        cell.stateLabel.text = favoriteTV.detail?.play_status
        cell.scoreLabel.text = favoriteTV.detail?.score
        cell.scoreCountLabel.text = "\(favoriteTV.detail?.score_counts ?? "0")人评价"

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
    
    
    func requestFavoriteTVList(_ page: Int) {

        zmzProvider.request(.favlist(page: page, limit: 10, ft: "resource")) { result in
            if let favoriteTVList = handleResponse(nil, type: [FavoriteTV].self, result: result) {
                if page > 1 {
                    self.dataArray?.append(contentsOf: favoriteTVList)
                } else {
                    self.dataArray = favoriteTVList
                }

                self.tableView.reloadData()

            }
        }
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteFavoriteAction = UITableViewRowAction(style: .normal, title: "取消收藏") { (action, index) in
            
        }
        deleteFavoriteAction.backgroundColor = .red
        return [deleteFavoriteAction]
    }


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
