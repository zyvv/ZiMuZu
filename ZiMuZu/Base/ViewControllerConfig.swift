//
//  ViewControllerConfig.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import Hue

extension UIViewController {
    
    func viewConfig() {
        let viewBackgroundColor: UIColor = UIColor(hex: "#0f1011")
        view.backgroundColor = viewBackgroundColor
    }
    
    func navigationConfig() {
        var navigationBarColor: UIColor = UIColor(hex: "#171717")
        navigationBarColor = navigationBarColor.alpha(0.76)
        navigationController?.navigationBar.barTintColor = navigationBarColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        navigationController?.navigationBar.tintColor = nil
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}