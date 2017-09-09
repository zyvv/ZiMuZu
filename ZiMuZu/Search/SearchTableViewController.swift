//
//  SearchTableViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/24.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import Moya

class SearchTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    let searchResultsController: SearchResultTableViewController = SearchResultTableViewController(style: .plain)
    var cancelRequest: Cancellable? = nil
    lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: searchResultsController)
    }()
    
    let searchHistroy: SearchHistory = SearchHistory()
    var historys: [String] = []
    var hotkeys: [HotKeyword] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewConfig()
        self.navigationConfig()
        self.navigationItem.title = "搜索"
    
        historys = searchHistroy.historys()
        tableView.backgroundColor = view.backgroundColor

        let searchBarTextAttributes: [String : AnyObject] = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.scopeButtonTitles = ["剧集", "新闻和剧评"]
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        
        requestHotkeywords()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - tableView delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        if historys.count > 0 && hotkeys.count > 0 { return 2 }
        if historys.count > 0 || hotkeys.count > 0 { return 1 }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if historys.count > 0 && hotkeys.count > 0 {
            if section == 0 { return historys.count }
            if section == 1 { return hotkeys.count }
        }
        if historys.count > 0 { return historys.count }
        if hotkeys.count > 0 { return hotkeys.count }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryCell", for: indexPath)
        cell.textLabel?.textColor = UIColor.lightGray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        if historys.count > 0 && hotkeys.count > 0 {
            if indexPath.section == 0 { cell.textLabel?.text = historys[indexPath.item] }
            if indexPath.section == 1 { cell.textLabel?.text = hotkeys[indexPath.item].keyword }
        } else {
            if historys.count > 0 { cell.textLabel?.text = historys[indexPath.item] }
            if hotkeys.count > 0 { cell.textLabel?.text = hotkeys[indexPath.item].keyword }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: SeachHistoryHeaderView = Bundle.main.loadNibNamed("SeachHistoryHeaderView", owner: self, options: nil)?.last as! SeachHistoryHeaderView
        headerView.clickClearButton = {
            self.clearHistory()
        }
        if historys.count > 0 && hotkeys.count > 0 {
            if section == 0 { headerView.handleButton.isHidden = false; headerView.name = "最近搜索"; headerView.handle = "清除"}
            if section == 1 { headerView.handleButton.isHidden = true; headerView.name = "热门搜索"; headerView.handle = "" }
        } else {
            if historys.count > 0 { headerView.handleButton.isHidden = false; headerView.name = "最近搜索"; headerView.handle = "清除" }
            if hotkeys.count > 0 { headerView.handleButton.isHidden = true; headerView.name = "热门搜索"; headerView.handle = "" }
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    func clearHistory() {
        let alertView = UIAlertController(title: nil, message: nil
            , preferredStyle: .actionSheet)
        alertView.view.tintColor = UIColor.red
        let action = UIAlertAction(title: "清除最近搜索", style: .default) { _ in
            if self.searchHistroy.deleteAllHistory() {
                self.historys = self.searchHistroy.historys()
                self.tableView.reloadData()
            }
        }
        let cancal = UIAlertAction(title: "取消", style: .cancel)
        alertView.addAction(action)
        alertView.addAction(cancal)
        self.present(alertView, animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        searchController.isActive = true
        searchController.searchBar.text = cell?.textLabel?.text
        
        // 保存到本地
        searchHistroy.addHistory(searchController.searchBar.text!)

    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        historys = searchHistroy.historys()
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if !(cancelRequest?.isCancelled ?? true) {
            cancelRequest?.cancel()
        }
        
        if (searchController.searchBar.text?.isEmpty)! {
            requestSearch(st: .none, k: "")
        } else if searchController.searchBar.selectedScopeButtonIndex == 0 {
            requestSearch(st: .resource, k: searchController.searchBar.text!)
        } else {
            requestSearch(st: .article, k: searchController.searchBar.text!)
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if !(cancelRequest?.isCancelled ?? true) {
            cancelRequest?.cancel()
        }
        if (searchBar.text?.isEmpty)! {
            requestSearch(st: .none, k: "")
        } else if selectedScope == 0 {
            requestSearch(st: .resource, k: searchBar.text!)
        } else {
            requestSearch(st: .article, k: searchBar.text!)
        }
        
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        // 保存到本地
        searchHistroy.addHistory(searchBar.text!)
    }
    
    func requestHotkeywords() {
        zmzProvider.request(.hotkeyword()) { result in
            let hotKeywordList = handleResponse(nil, type: [HotKeyword].self, result: result)
            if let hotKeywordList = hotKeywordList {
                self.hotkeys = hotKeywordList
                self.tableView.reloadData()
            }
        }
    }
    
    
    func requestSearch(st: SearchType, k: String) {
        
        self.searchResultsController.reload(type: .none, dataArray: [])
        if k == "" {
            return
        }
        
       cancelRequest = zmzProvider.request(.search(st: st.rawValue, k: k)) { result in
            if st == .resource {
                if let resultTV = handleResponse(nil, type: SearchTVResult.self, result: result) {
                    self.searchResultsController.reload(type: .resource, dataArray: resultTV.list)
                }
            }
            
            if st == .article {
                if let resultNews = handleResponse(nil, type: SearchNewsResult.self, result: result) {
                    self.searchResultsController.reload(type: .article, dataArray: resultNews.list)
                }
            }

        }
    }

}
