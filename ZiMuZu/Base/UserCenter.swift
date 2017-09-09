//
//  UserCenter.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/16.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class UserCenter: NSObject {
    
    let user_id = "user_id"
    let user_token = "user_token"
    let user_nickname = "user_nickname"
    
    static let sharedInstance = UserCenter()
    
    var uid: String? {
        get {
            return UserDefaults.standard.object(forKey: user_id) as! String?
        }
        set (newUid){
            UserDefaults.standard.set(newUid, forKey: user_id)
        }
    }
    
    var userToken: String? {
        get {
            return UserDefaults.standard.object(forKey: user_token) as! String?
        }
        set (newUserToken){
            UserDefaults.standard.set(newUserToken, forKey: user_token)
        }
    }
    
    var nickName: String? {
        get {
            return UserDefaults.standard.object(forKey: user_nickname) as! String?
        }
        set {
            UserDefaults.standard.set(nickName, forKey: user_nickname)
        }
    }
    
    var isLogin: Bool {
        get {
            let loginState = (self.uid != nil) ? true : false
            return loginState
        }
    }
    
    func loginOut() {
        UserDefaults.standard.removeObject(forKey: user_id)
        UserDefaults.standard.removeObject(forKey: user_nickname)
        UserDefaults.standard.removeObject(forKey: user_token)
    }
    
    func login(_ user: User) {
        self.uid = user.uid
        self.nickName = user.nickname
        self.userToken = user.token
    }
    
    private override init() {}
}
