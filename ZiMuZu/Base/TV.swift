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
    let title: String?
    
    override init() {
        self.cnname = nil
        self.enname = nil
        self.episode = nil
        self.season = nil
        self.id = nil
        self.play_time = nil
        self.poster = nil
        self.title = nil
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

struct TVScheduleDataCodingOptions {
    enum TVScheduleDataType: String {
        case todayList = "today"
        case favWeekList = "fav_week_list"
        case tvWeekList = "tv_week_list"
        case movieMonthList = "movie_month_list"
        case tvTotalList = "tv_total_list"
        case hotJapanList = "hot_japan_list"
        case playing = "playing"
    }
    let tvScheduleDataType = TVScheduleDataType.todayList
    static let key = CodingUserInfoKey(rawValue: "TVScheduleDataCodingOption")!
}


struct TVSchedule: Codable {
    struct ScheduleDateKey : CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }
    
    var tvs: [TV] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ScheduleDateKey.self)
        do {
            
            var scheduleKey = today()
            guard let scheduleOptionKey: TVScheduleDataCodingOptions.TVScheduleDataType = decoder.userInfo[TVScheduleDataCodingOptions.key] as? TVScheduleDataCodingOptions.TVScheduleDataType else {
                return
            }
            
            if scheduleOptionKey != TVScheduleDataCodingOptions.TVScheduleDataType.todayList {
                scheduleKey = scheduleOptionKey.rawValue
            }
            
            let tvs = try container.decode([TV].self, forKey: TVSchedule.ScheduleDateKey(stringValue: scheduleKey)!)
            self.tvs = tvs
            
        } catch {
            print(error)
        }
    }
    
    func encode(to encoder: Encoder) throws {
    }
}

final class HomeSectionList {
    let list: [Any]
    let title: String
    let handle: String
    
    init(list: [Any], title: String, handle: String) {
        self.list = list
        self.title = title
        self.handle = handle
    }
}

extension HomeSectionList: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self as! NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(toDiffableObject: object)
    }
}

