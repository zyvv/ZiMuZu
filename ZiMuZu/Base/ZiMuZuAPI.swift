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

let zmzProvider = MoyaProvider<ZiMuZu>()

public enum ZiMuZu {
    case tv_schedule()
}

extension ZiMuZu: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api1.ousns.net/index.php")!
    }
    
    public var path: String {
        switch self {
        case .tv_schedule():
            return "/"
        default:
            <#code#>
        }
    }
    
    public var method: Method {
//        switch self {
//        case :
//            <#code#>
//        default:
//            <#code#>
//        }
    }
    
    public var parameters: [String : Any]? {
        <#code#>
    }
    
    public var parameterEncoding: ParameterEncoding {
        <#code#>
    }
    
    public var sampleData: Data {
        <#code#>
    }
    
    public var task: Task {
        <#code#>
    }
    
    public var headers: [String : String]? {
        <#code#>
    }
    
    
}


