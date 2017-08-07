//
//  NewsCell.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var newsType: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
