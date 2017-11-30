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
    private let userId = "user_id"
    private let userNickname = "user_nickname"
    private let userToken = "user_token"
    
    var uid: String? {
        get {
            return UserDefaults.standard.object(forKey: userId) as! String?
        }
        set (newUid) {
            UserDefaults.standard.set(newUid, forKey: userId)
        }
    }
    
    var uToken: String? {
        get {
            return UserDefaults.standard.object(forKey: userToken) as! String?
        }
        set (newUToken){
            UserDefaults.standard.set(newUToken, forKey: userToken)
        }
    }
    
    var nickName: String? {
        get {
            return UserDefaults.standard.object(forKey: userNickname) as! String?
        }
        set (newNickName) {
            UserDefaults.standard.set(newNickName, forKey: userNickname)
        }
    }
    
    var isLogin: Bool {
        get {
            let loginState = (self.uid != nil) ? true : false
            return loginState
        }
    }
    
    func loginOut() {
        UserDefaults.standard.removeObject(forKey: userId)
        UserDefaults.standard.removeObject(forKey: userNickname)
        UserDefaults.standard.removeObject(forKey: userToken)
    }
    
    func login(_ user: User) {
        self.uid = user.uid
        self.nickName = user.nickname
        self.uToken = user.token
    }
    
    private override init() {}
}
