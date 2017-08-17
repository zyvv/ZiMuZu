//
//  HomeHeaderView.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/7.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class HomeHeaderView: UICollectionReusableView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var handleButton: UIButton!
    
     typealias ClickButton = () -> Void
    
    var clickButton: ClickButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func handleButtonAction(_ sender: Any) {
        guard let clickButton = clickButton else {
            return
        }
        clickButton()
    }
    
    func tapHandleButton(callBack: @escaping ClickButton) {
        clickButton = callBack
    }
    
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
            return handleButton.titleLabel?.text
        }
        set {
            handleButton.setTitle(newValue, for: .normal)
        }
    }
    
//    var tapHandleButton: () -> (Void)
    
}
