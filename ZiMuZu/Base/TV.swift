//
//  TV.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/3.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation

struct TV: Codable {
    let cnname: String
    let enname: String
    let episode: Int
    let season: Int
    let id: Int
    let play_time: String
    let poster: URL
}

//struct TVSchedule: Codable {
//    struct Data: Codable {
//
//
//    }
//    let data: String
//    let info: String
//    let status: Int
//}


