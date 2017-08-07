//
//  News.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation
import IGListKit

final class News: NSObject, Codable {
    
    let title: String?
    let id: String?
    let dateline: String?
    let poster: URL?
    let type_cn: String?
    
    override init() {
        self.title = nil
        self.id = nil
        self.dateline = nil
        self.poster = nil
        self.type_cn = nil
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

struct NewsList: Codable {
    let data: [News]
    let info: String
    let status: Int
}
