//
//  TVDetailSectionController.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/22.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import IGListKit

class TVDetailSectionController: ListSectionController {
    
    let posterCellID = "TVDetailPosterCell"
    let rateCellID = "TVDetailRateCell"
    let alertCellID = "TVDetailAlertCell"
    let descCellID = "TVDetailDescCell"
    let menuCellID = "TVDetailMenuCell"
    let resourceCellID = "TVDetailResouceCell"
    
    private var tvDetail: TVDetail?
    private var expanded = false
    
    override init() {
        super.init()
        
    }
    
    override func numberOfItems() -> Int {
        return 9
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        switch index {
        case 0: // 海报
            return CGSize(width: width, height: 300)
        case 1: // 评分
            return CGSize(width: width, height: 135)
        case 2: // 下集提示
            return CGSize(width: width, height: 30)
        case 3: // 剧情简介标题
            return CGSize(width: width, height: 0)
        case 4: // 剧情简介
            let height = expanded ? TVDetailDescCell.textHeight(tvDetail?.resource?.content ?? "", width: width) : TVDetailDescCell.singleLineHeight
            return CGSize(width: width, height: height)
        case 5: // 资源下载
            return CGSize(width: width, height: 100)
        case 6: // 相关剧集标题
            return CGSize(width: width, height: 50)
        default:
            return CGSize(width: width, height: 300)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0: // poster
            let cell: TVDetailPosterCell = collectionContext?.dequeueReusableCell(withNibName: posterCellID, bundle: nil, for: self, at: index) as! TVDetailPosterCell
            cell.tvDetail = self.tvDetail
            return cell
        case 1: // rate
            let cell: TVDetailRateCell = collectionContext?.dequeueReusableCell(withNibName: rateCellID, bundle: nil, for: self, at: index) as! TVDetailRateCell
            cell.tvDetail = self.tvDetail
            return cell
        case 2:
            let cell: TVDetailAlertCell = collectionContext?.dequeueReusableCell(withNibName: alertCellID, bundle: nil, for: self, at: index) as! TVDetailAlertCell
            return cell
        case 3:
            let cell: TVDetailMenuCell = collectionContext?.dequeueReusableCell(withNibName: menuCellID, bundle: nil, for: self, at: index) as! TVDetailMenuCell
            cell.menuLabel.text = "剧情简介"
            return cell
        case 4:
            let cell: TVDetailDescCell = collectionContext?.dequeueReusableCell(withNibName: descCellID, bundle: nil, for: self, at: index) as! TVDetailDescCell
            cell.tvDetail = self.tvDetail
            if !expanded {
                let width = collectionContext?.containerSize.width ?? 0
                cell.hiddenMoreButton = (TVDetailDescCell.textHeight(tvDetail?.resource?.content ?? "", width: width)  < TVDetailDescCell.singleLineHeight)
            } else {
                cell.hiddenMoreButton = true
            } 
            cell.updateDescCellHeight {
                self.expanded = true
                self.collectionContext?.invalidateLayout(for: self)
            }
            return cell
        case 5:
            let cell: TVDetailResouceCell = collectionContext?.dequeueReusableCell(withNibName: resourceCellID, bundle: nil, for: self, at: index) as! TVDetailResouceCell
            return cell
        case 6:
            let cell: TVDetailMenuCell = collectionContext?.dequeueReusableCell(withNibName: menuCellID, bundle: nil, for: self, at: index) as! TVDetailMenuCell
            cell.menuLabel.text = "相关剧集"
            return cell
        default:
            let cell = collectionContext?.dequeueReusableCell(withNibName: posterCellID, bundle: nil, for: self, at: index) as! TVDetailPosterCell
            return cell
        }
    }
    
    override func didUpdate(to object: Any) {
        self.tvDetail = object as? TVDetail
    }
    
}
