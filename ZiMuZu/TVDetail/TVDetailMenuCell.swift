//
//  TVDetailMenuCell.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/22.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class TVDetailMenuCell: UICollectionViewCell {

    @IBOutlet weak var menuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(hex: "#0f1011")
    }

}
