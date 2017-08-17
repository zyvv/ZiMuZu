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

class LoginViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, LoginToolViewDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let keyboard = Typist.shared
    let loginToolViewHeight: CGFloat = 44.0
    
    lazy var loginToolView: LoginToolView = {
        let toolView = Bundle.main.loadNibNamed("LoginToolView", owner: self, options: nil)?.last as! LoginToolView
        toolView.frame = CGRect(x: 0, y: kScreenHeight + loginToolViewHeight, width: view.frame.size.width, height: loginToolViewHeight)
        toolView.delegate = self
        view.addSubview(toolView)
        return toolView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        navigationConfig()
        navigationItem.largeTitleDisplayMode = .always
        title = "登录"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboard
            .on(event: .willChangeFrame, do: { (options) in
                self.keyboardFrameChange(options.endFrame.minY)
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
    
    func keyboardFrameChange(_ top: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.loginToolView.frame = CGRect(origin: CGPoint(x: self.loginToolView.frame.minX, y: top - self.loginToolViewHeight), size: self.loginToolView.frame.size)
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
            guard let user = handleResponse(User.self, result: result) else {
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
