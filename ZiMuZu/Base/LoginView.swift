//
//  LoginView.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/16.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import SafariServices

class LoginView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewControllerNavi")
        self.viewController()?.present(loginVC, animated: true, completion: nil)
    }
    @IBAction func registerButtonAction(_ sender: UIButton) {
        let safariVC = SFSafariViewController(url: URL(string: "http://www.zimuzu.tv/user/reg")!)
        safariVC.preferredBarTintColor = viewController()?.navigationController?.navigationBar.barTintColor
        safariVC.preferredControlTintColor = .white
        self.viewController()?.present(safariVC, animated: true, completion: nil)
    }
    
}


extension UIView {
    func viewController() -> UIViewController? {
        var view: UIResponder? = self
        repeat {
            let nextResponder = view?.next
            if nextResponder?.isKind(of: UIViewController.self) ?? false {
                return nextResponder as? UIViewController
            }
            view = view?.next
        } while view?.next != nil
        return nil
    }
}

