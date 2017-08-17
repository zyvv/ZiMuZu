//
//  HomeListCell.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class HomeListCell: UICollectionViewCell {

    @IBOutlet weak var tvImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tvImageView.layer.cornerRadius = 5
        tvImageView.layer.masksToBounds = true
    }

}
