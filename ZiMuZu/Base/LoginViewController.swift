//
//  LoginViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/16.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import Typist
import Moya
import SnapKit

class LoginViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, LoginToolViewDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let keyboard = Typist.shared
    let loginToolViewHeight: CGFloat = 44.0
    
    lazy var loginToolView: LoginToolView = {
        let toolView = Bundle.main.loadNibNamed("LoginToolView", owner: self, options: nil)?.last as! LoginToolView
        toolView.delegate = self
        view.addSubview(toolView)
        toolView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(loginToolViewHeight)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(self.view)
        }
        
        return toolView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        navigationConfig()
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
        } else {
            // Fallback on earlier versions
        }
        title = "登录"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboard
            .on(event: .willChangeFrame, do: { (options) in
                self.keyboardFrameChange(options.endFrame.height)
            })
            .on(event: .willHide, do: { (options) in
                self.keyboardFrameChange(0)
            })
            .start()
        emailTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keyboard.stop()
        keyboard.clear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardFrameChange(_ height: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.loginToolView.snp.updateConstraints({ (make) -> Void in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-height)
            })
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func backItemAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            requestLogin()
        }
        return true
    }
    

    func requestLogin() {
        if emailTextField.text == nil || passwordTextField.text == nil {
            return
        }
        zmzProvider.request(.login(account: emailTextField.text!, password: passwordTextField.text!)) { result in
            guard let user = handleResponse(nil, type: User.self, result: result) else {
                return
            }
            UserCenter.sharedInstance.login(user)
            self.navigationController?.dismiss(animated: true, completion: nil)
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
        }
    }
    
    func loginAction() {
        requestLogin()
    }
    
}

extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [NSAttributedStringKey.foregroundColor : newValue]
            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
        }
    }
}
