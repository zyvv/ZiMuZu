//
//  UserCenter.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/16.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class UserCenter: NSObject {
    static let sharedInstance = UserCenter()
    
    var uid: String? {
        get {
            return UserDefaults.standard.object(forKey: "user_uid") as! String?
        }
        set {
            UserDefaults.standard.set(uid, forKey: "user_uid")
        }
    }
    
    var nickName: String? {
        get {
            return UserDefaults.standard.object(forKey: "user_nickname") as! String?
        }
        set {
            UserDefaults.standard.set(nickName, forKey: "user_nickname")
        }
    }
    
    var isLogin: Bool {
        get {
            let loginState = (UserCenter().uid != nil) ? true : false
            return loginState
        }
    }
    
    func loginOut() {
        UserDefaults.standard.removeObject(forKey: "user_uid")
        UserDefaults.standard.removeObject(forKey: "user_nickname")
    }
    
    func login(_ user: User) {
        self.uid = user.uid
        self.nickName = user.nickname
    }
    
    private override init() {}
}
