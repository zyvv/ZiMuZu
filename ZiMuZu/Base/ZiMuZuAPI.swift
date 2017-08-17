//
//  ZiMuZuAPI.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation
import Moya
import Result
import PKHUD

let accesskey = "519f9cab85c8059d17544947k361a827"

let customParameters = { () -> [String : String] in
    var parameters = ["accesskey": accesskey,
                      "client": "1",
                      "g": "api/v2",
                      "m": "index"]
    if UserCenter.sharedInstance.isLogin {
        parameters["uid"] = UserCenter.sharedInstance.uid!
    }
    return parameters
}()

let endpointClosure: (ZiMuZu) -> Endpoint<ZiMuZu> = { (target: ZiMuZu) -> Endpoint<ZiMuZu> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint = Endpoint<ZiMuZu>(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters).adding(newParameters:customParameters)
    return endpoint
}

struct ResponsePlugin {
    
}

extension ResponsePlugin: PluginType {
    
    enum ZiMuZuError: Error {
        case errorInfo(info: String)
        case errorParsingData(_: String)
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
//        print(request, target)
    }
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {

        var result = result
        
        // 成功返回后台数据
        if case .success(let response) = result {

            // 解析后台数据 key为data部分
            if let filterResponse = try? response.filterData() {
                
                // 后台数据提示错误
                if filterResponse.statusCode != 1 {
                    let errorInfo = String(data: filterResponse.data, encoding: .utf8)
                    result = Result.failure(MoyaError.underlying(ZiMuZuError.errorInfo(info: errorInfo ?? ""), filterResponse))
                } else {
                    result = Result.success(filterResponse)
                }
                
            } else {
                result = Result.failure(MoyaError.underlying(ZiMuZuError.errorParsingData("解析data数据出错"), response))
            }
        }
        return result
    }
}

let responsePlugin = ResponsePlugin()

let networkActivityPlugin = NetworkActivityPlugin { state in
    if state == .began {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    } else {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}


let zmzProvider = MoyaProvider(endpointClosure: endpointClosure, plugins: [responsePlugin, networkActivityPlugin])

public enum ZiMuZu {
    case tv_schedule()
    case top()
    case articleList(page: Int)
    case article(id: String)
    case login(account: String, password: String)
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
        case .article( _):
            return "".data(using: String.Encoding.utf8)!
        case .login( _, _):
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
//        switch self {
//        case .login( _, _):
//            return .post
//        default:
            return .get
//        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .tv_schedule():
            return ["a": "tv_schedule", "start": today(), "end": today()]
        case .top():
            return ["a": "top"]
        case .articleList(let page):
            return ["a": "article_list", "page": page]
        case .article(let id):
            return ["a": "article", "id": id]
        case .login(let account, let password):
            return ["a": "login", "account": account, "password": password]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        return .request
    }
}

extension Moya.Response {
    func filterData() throws -> Response {
        let responseData = try mapJSON() as! Dictionary<String, Any>
        let status: Int = responseData["status"] as! Int
        switch status {
        case 1:
            let filterDataObj = responseData["data"] as Any
            let filterData = try JSONSerialization.data(withJSONObject: filterDataObj, options: .prettyPrinted)
            return Response(statusCode: status, data: filterData, request: request, response: response)
        default:
            let filterInfo: String? = responseData["info"] as? String
            return Response(statusCode: status, data: filterInfo?.data(using: .utf8) ?? Data(), request: request, response: response)
        }
    }
}

func handleResponse<T>(_ type: T.Type, result: Result<Moya.Response, MoyaError>) -> T? where T: Codable {
    do {
        if case let .success(response) = result {
            let responseData: T = try JSONDecoder().decode(type, from: response.data)
            return responseData
        }
        if case let .failure(error) = result {
            if case let MoyaError.underlying(zimuzuError, _) = error {
                if case let ResponsePlugin.ZiMuZuError.errorInfo(errorInfo) = zimuzuError {
                    HUD.flash(.label(errorInfo), delay: 1.0)
                } else if case let ResponsePlugin.ZiMuZuError.errorParsingData(errorInfo) = zimuzuError {
                    HUD.flash(.label(errorInfo), delay: 1.0)
                } else {
                    HUD.flash(.label(zimuzuError.localizedDescription), delay: 1.0)
                }
                return nil
            }
        }
    } catch {
        HUD.flash(.label("出现未知错误"), delay: 1.0)
        return nil
    }
    return nil
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

