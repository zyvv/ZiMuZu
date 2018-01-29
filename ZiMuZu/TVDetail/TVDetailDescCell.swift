//
//  TVDetailDescCell.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/22.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class TVDetailDescCell: UICollectionViewCell {
    
    fileprivate static let font = UIFont.systemFont(ofSize: 13)
    fileprivate static let fontAttributes: [NSAttributedStringKey: Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .left
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: font, NSAttributedStringKey.paragraphStyle: paragraphStyle]
        return attributes
    }()
    var updateCellHeight: (() -> Void)? = nil
    
    var tvDetail: TVDetail? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var hiddenMoreButton: Bool = false {
        didSet {
            moreButton.isHidden = hiddenMoreButton
        }
    }
    
    static var singleLineHeight: CGFloat {
        return font.lineHeight * 3 + 10.6 // ?
    }
    
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width - 30, height: CGFloat.greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: fontAttributes, context: nil)
        return ceil(bounds.height)
    }
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "#0f1011")
    }
    
    @IBAction func moreButtonAction(_ sender: UIButton) {
        if let updateCellHeight = updateCellHeight {
            updateCellHeight()
            sender.isHidden = true
        }
    }
    
    func updateDescCellHeight(update:@escaping () -> Void) {
        updateCellHeight = update
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let desc = tvDetail?.resource?.content {
            let attrDesc = NSAttributedString(string: desc, attributes: TVDetailDescCell.fontAttributes)
            descLabel.attributedText = attrDesc
        }
    }
}
