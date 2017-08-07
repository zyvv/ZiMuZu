//
//  HomeHeaderView.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class HomeHeaderView: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var handleLabel: UILabel!
    
    var name: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var handle: String? {
        get {
            return handleLabel.text
        }
        set {
            handleLabel.text = newValue
        }
    }

}
