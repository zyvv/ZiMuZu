//
//  ViewControllerConfig.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/2.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import Hue

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

extension UIViewController {
    
    func viewConfig() {
//        let viewBackgroundColor: UIColor = UIColor(hex: "#F3F5FA")
        let viewBackgroundColor: UIColor = UIColor(hex: "#0f1011")
        view.backgroundColor = viewBackgroundColor
    }
    
    func navigationConfig() {
        var navigationBarColor: UIColor = UIColor(hex: "#171717")
        navigationBarColor = navigationBarColor.alpha(0.76)
        navigationController?.navigationBar.barTintColor = navigationBarColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            if navigationController?.viewControllers.count == 1 {
                navigationItem.largeTitleDisplayMode = .automatic
            } else {
                navigationItem.largeTitleDisplayMode = .never
            }
        } else {
            // Fallback on earlier versions
        }

    }
}
