//
//  NewsListCell.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/9.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class NewsListCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var newsType: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsIntro: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    var news: News? {
        didSet {
            setNeedsLayout()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.cornerRadius = 2
        posterImageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTitle.text = news?.title
        newsType.text = news?.type_cn
        newsIntro.text = news?.intro
        posterImageView.kf.setImage(with: news?.poster)
        postDate.text = news?.datelineString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
