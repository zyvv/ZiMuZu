//
//  NewsListCell.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/8.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class NewsListCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var newsType: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsIntro: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.cornerRadius = 2
        posterImageView.layer.masksToBounds = true
    }
    

}
