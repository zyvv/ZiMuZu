//
//  TVListViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/8.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

//<<<<<<< HEAD
//private let reuseIdentifier = "TVCell"
//
//class TVListLayout: UICollectionViewFlowLayout {
//    override init() {
//        super.init()
//        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
//        self.minimumInteritemSpacing = 15
//        self.minimumLineSpacing = 10
//        let width = min((kScreenWidth - 20 - 15 * 2) / 3.0, 200)
//        self.itemSize = CGSize(width: width, height: width * (1/0.68) + 27)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
class TVListViewController: UITableViewController {
    
    var dataArray: [TV]? {
        didSet {
//            navigationController?.navigationBar.tintColor = UIColor.yellow
//            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        navigationConfig()
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    //        navigationItem.largeTitleDisplayMode = .never
    //    navigationController?.navigationBar.tintColor = UIColor.yellow
        tableView.separatorStyle = .none
        tableView.backgroundColor = view.backgroundColor
        tableView.register(UINib.init(nibName: "FavoriteTVCell", bundle: nil), forCellReuseIdentifier: "FavoriteTVCell")
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
    
    let favoriteTV: TV = dataArray![indexPath.section] as TV
    cell.posterImageView.kf.setImage(with: favoriteTV.poster)
//    cell.typeLabel.text = favoriteTV.channel_cn
    cell.nameLabel.text = favoriteTV.title
//    cell.stateLabel.text = favoriteTV.play_status
//    cell.scoreLabel.text = favoriteTV.score
        cell.scoreCountLabel.text = "#\(indexPath.section + 1)"
    
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

}
