//
//  SeachHistoryHeaderView.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/24.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class SeachHistoryHeaderView: UIView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet weak var handleButton: UIButton!
    
    typealias ClickClearButton = () -> Void
    
    var clickClearButton: ClickClearButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func handleButtonAction(_ sender: Any) {
        guard let clickClearButton = clickClearButton else {
            return
        }
        clickClearButton()
    }
    
    func tapHandleButton(callBack: @escaping ClickClearButton) {
        clickClearButton = callBack
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
}
