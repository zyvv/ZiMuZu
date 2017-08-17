//
//  LoginToolView.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/16.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import SafariServices

protocol LoginToolViewDelegate: class {
    func loginAction()
}

class LoginToolView: UIView {
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegate: LoginToolViewDelegate?
    
    @IBAction func forgetPasswordButtonAction(_ sender: UIButton) {
        
        let safariVC = SFSafariViewController(url: URL(string: "http://www.zimuzu.tv/user/password/forgot")!)
        safariVC.preferredBarTintColor = viewController()?.navigationController?.navigationBar.barTintColor
        safariVC.preferredControlTintColor = .white
        self.viewController()?.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        delegate?.loginAction()
    }
}
