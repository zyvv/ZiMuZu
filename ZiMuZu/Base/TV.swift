//
//  TV.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/3.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import Foundation
import IGListKit

struct HotKeyword: Decodable {
    let keyword: String
}

final class SearchTVResult: NSObject, Decodable {
    let count: Int
    let list: [TV]?
    
    override init() {
        self.count = 0
        self.list = nil
    }
}


final class FavoriteTV: NSObject, Decodable {
    let type: String?
//    let channel: String?
    let itemid: String?
    let uid: String?
    let dateline: String?
    let updatetime: String?
    let area: String?
    let detail: TV?
    
    override init() {
        self.type = nil
        self.itemid = nil
        self.uid = nil
        self.dateline = nil
        self.updatetime = nil
        self.area = nil
        self.detail = nil
    }
}

extension FavoriteTV: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

final class TV: NSObject, Decodable {
    let cnname: String?
    let enname: String?
    let episode: String?
    let season: String?
    let id: String?
    let play_time: String?
    let poster: URL?
    let title: String?
    let play_status: String?
    let channel_cn: String?
    let poster_b: URL?
    let page_description: String?
    let score: String?
    let score_counts: String?
    let area: String?
    let channel: String?
    
    lazy var customChannel: String = {

        if self.area != nil && self.channel != nil {
            if self.channel == "tv" {
                return "电视剧 "+self.area!
            }
            if self.channel == "movie" {
                return "电视 "+self.area!
            }
            return self.channel!+" "+self.area!
        }
        if self.area != nil {
            return self.area!
        }
        if self.channel != nil {
            if self.channel == "tv" {
                return "电视剧"
            }
            if self.channel == "movie" {
                return "电视"
            }
            return self.channel!
        }
        return ""
    }()

    
    override init() {
        self.cnname = nil
        self.enname = nil
        self.episode = nil
        self.season = nil
        self.id = nil
        self.play_time = nil
        self.poster = nil
        self.title = nil
        self.play_status = nil
        self.channel_cn = nil
        self.poster_b = nil
        self.page_description = nil
        self.score = nil
        self.score_counts = nil
        self.area = nil
        self.channel = nil
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

enum SearchType: String {
    case resource = "resource"
    case article = "article"
    case none = "none"
}

