//
//  TVDetailRateCell.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/20.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class TVDetailRateCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var enNameLabel: UILabel!
    
    var tvDetail: TVDetail? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(hex: "#0f1011")
        titleLabel.adjustsFontSizeToFitWidth = true
        enNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.text = tvDetail?.resource?.cnname
        enNameLabel.text = tvDetail?.resource?.enname
        
        let statusString = NSMutableAttributedString()
        if let channelCn = tvDetail?.resource?.channel_cn {
            statusString.appendString("\(channelCn)\n")
        }
        if let playStatus = tvDetail?.resource?.play_status {
            statusString.appendString("\(playStatus)")
        }
        let statusParagraphStyle = NSMutableParagraphStyle()
        statusParagraphStyle.lineSpacing = 5
        statusParagraphStyle.alignment = .left
        let statusAttributes = [NSAttributedStringKey.foregroundColor: UIColor(hex: "#B9B9B9"), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.paragraphStyle: statusParagraphStyle]
        if statusString.length > 0 {
            statusString.setAttributes(statusAttributes, range: NSMakeRange(0, statusString.length))
            statusTextView.attributedText = statusString
        }
    }

}
