//
//  TVCell.swift
//  ZiMuZu
//
//  Created by vi~ on 2017/8/6.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class TVCell: UICollectionViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var cnName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        poster.layer.cornerRadius = 8
        poster.layer.masksToBounds = true
    }

}
