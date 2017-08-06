//
//  TV.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/3.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation
import IGListKit

final class TV: NSObject, Decodable {
    let cnname: String?
    let enname: String?
    let episode: String?
    let season: String?
    let id: String?
    let play_time: String?
    let poster: URL?
    
    override init() {
        self.cnname = nil
        self.enname = nil
        self.episode = nil
        self.season = nil
        self.id = nil
        self.play_time = nil
        self.poster = nil
    }
}


extension TV: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

struct TVScheduleData: Codable {
    
    struct ScheduleDateKey : CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
        
        static let todayTVs = ScheduleDateKey(stringValue: today())!
    }
    
    var todayTVs: [TV] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ScheduleDateKey.self)
        do {
            let todayTVs = try container.decode([TV].self, forKey: .todayTVs)
            self.todayTVs = todayTVs
        } catch {
            print(error)
        }
    }
    
    func encode(to encoder: Encoder) throws {
    }
}

struct TVSchedule: Codable {
    let data: TVScheduleData
    let info: String
    let status: Int
}

final class TodayTVs {
    let tvs: [TV]
    init(tvs: [TV]) {
        self.tvs = tvs
    }
}

extension TodayTVs: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self as! NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(toDiffableObject: object)
    }
}

