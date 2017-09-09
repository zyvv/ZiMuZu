//
//  News.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation
import IGListKit

final class SearchNewsResult: NSObject, Decodable {
    let count: Int
    let list: [News]?
    
    override init() {
        self.count = 0
        self.list = nil
    }
}

final class FavoriteNews: NSObject, Codable {
    let dateline: String?
    let detail: News?
    
    override init() {
        self.dateline = nil
        self.detail = nil
    }
}

final class News: NSObject, Codable {
    
    let title: String?
    let id: String?
    let dateline: String?
    let poster: URL?
    let type_cn: String?
    let intro: String?
    let poster_b: URL?
    let pubtime: String?
    
    lazy var datelineString: String = {
        let duratinInterval = Date().timeIntervalSince1970 - Double(dateline ?? pubtime ?? "0.0")!
        switch duratinInterval {
        case 0..<60:
            return "刚刚"
        case 60..<3600:
            return "\(Int(duratinInterval / 60.0))分钟前"
        case 3600..<24*3600:
            return "\(Int(duratinInterval / (3600.0)))小时前"
        case 24*3600..<24*3600*7:
            return "\(Int(duratinInterval / (24 * 3600.0)))天前"
        case 24*3600*7..<24*3600*7*4:
            return "\(Int(duratinInterval / (24 * 3600 * 7.0)))周前"
        case 24*3600*7*4..<24*3600*365:
            return "\(Int(duratinInterval / (24 * 3600 * 4 * 7.0)))月前"
        default:
            return "\(Int(duratinInterval / (24 * 3600 * 365.0)))年前"
        }
    }()
    
    override init() {
        self.title = nil
        self.id = nil
        self.dateline = nil
        self.poster = nil
        self.type_cn = nil
        self.intro = nil
        self.poster_b = nil
        self.pubtime = nil
    }
}

extension News: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

struct NewsDetail: Codable {
    let content: String
}
