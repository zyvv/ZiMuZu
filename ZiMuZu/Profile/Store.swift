//
//  Store.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/18.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation
import SQLite

protocol Stroeable {
    
}

final class SearchHistory: NSObject {
    
    var db: Connection?
    let historyTable = Table("searchHistroys")
    
    let idKey = Expression<Int64>("id")
    let historyKey = Expression<String>("history")
    
    override init() {
        super.init()
        self.createTable()
    }
    
    private func createTable() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            self.db = try Connection("\(path)/searchHistorys.sqlite")
            try self.db?.run(historyTable.create(ifNotExists: true) { t in
                t.column(idKey, primaryKey: true)
                t.column(historyKey, unique: true)
            })
        } catch {
            print(error)
        }
    }
    
    func addHistory(_ history: String) {
        do {
            try db?.run(historyTable.insert(or: .replace, historyKey <- history))
            let count: Int = try db?.scalar(historyTable.count) ?? 0
            if count > 300 {
                let query = historyTable.order(idKey).limit(1)
                guard  let items = try db?.prepare(query) else {
                    return
                }
                for item in items {
                    let alice = historyTable.filter(historyKey == item[historyKey])
                    try db?.run(alice.delete())
                }
            }
        } catch {
            
        }
    }
    
    func deleteHistory(_ history: String) -> Bool {
        let deleteItem = historyTable.filter(historyKey == history)
        do {
            try db?.run(deleteItem.delete())
            return true
        } catch {
            return false
        }
    }
    
    func  deleteAllHistory() -> Bool {
        do {
            try db?.run(historyTable.delete())
            return true
        } catch {
            return false
        }
    }
    
    func historys() -> [String] {
        let query = historyTable.order(idKey.desc).select(historyKey).limit(10)
        do {
            guard  let items = try db?.prepare(query) else {
                return []
            }
            var historys = [String]()
            for item in items {
                historys.append(item[historyKey])
            }
            return historys
        } catch  {
            return []
        }

    }
}
