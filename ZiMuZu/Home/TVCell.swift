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
        
        poster.layer.masksToBounds = true
        if UI_USER_INTERFACE_IDIOM() == .pad {
            poster.layer.cornerRadius = 10
            cnName.font = UIFont.systemFont(ofSize: 20)
        } else {
            poster.layer.cornerRadius = 8
        }
    }

}
