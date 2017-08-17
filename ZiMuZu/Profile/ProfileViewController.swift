//
//  ProfileViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var loginView: LoginView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewConfig()
        self.navigationConfig()
        self.navigationItem.title = "记录"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UserCenter.sharedInstance.isLogin && loginView == nil {
            loginView = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.last as? LoginView
            loginView?.frame = view.bounds
            view.addSubview(loginView!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
