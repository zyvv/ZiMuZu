//
//  ZiMuZuAPI.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation
import Moya

let accesskey = "519f9cab85c8059d17544947k361a827"

let customParameters = ["accesskey": accesskey,
                        "client": "1",
                        "g": "api/v2",
                        "m": "index"]

let zmzProvider = MoyaProvider<ZiMuZu>()

public enum ZiMuZu {
    case tv_schedule()
    case top()
    case articleList(page: Int)
}

extension ZiMuZu: TargetType {
    public var sampleData: Data {
        switch self {
        case .tv_schedule():
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .top():
            return "".data(using: String.Encoding.utf8)!
        case .articleList( _):
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var baseURL: URL {
        return URL(string: "https://api1.ousns.net")!
    }
    
    public var path: String {
        return "index.php"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .tv_schedule():
            return ["a": "tv_schedule", "start": today(), "end": today()].merging(customParameters) {(_, new) in new}
        case .top():
            return ["a": "top"].merging(customParameters) {(_, new) in new}
        case .articleList(let page):
            return ["a": "article_list", "page": page].merging(customParameters) {(_, new) in new}
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        return .request
    }
}

func today() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "zh-CN")
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: Date())
}

func tomorrow() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "zh-CN")
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: Date.init(timeIntervalSinceNow: 24 * 60 * 60))
}

