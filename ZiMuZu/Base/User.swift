//
//  User.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/16.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation

struct User: Codable {
    let uid: String
    let sex: String
    let email: String
    let userpic: URL
    let token: String
    let group_name: String
    let nickname: String
}
