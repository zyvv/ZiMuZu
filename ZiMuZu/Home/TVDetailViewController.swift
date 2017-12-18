//
//  TVDetailViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/21.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import UIImageColors
import Kingfisher

class TVDetailViewController: UIViewController {
    
    var tv: TV? {
        didSet {
            guard let itemId = tv?.id else {
                return
            }
            self.title = tv?.cnname

            /*
             public var background: UIColor!
             public var primary: UIColor!
             public var secondary: UIColor!
             public var detail: UIColor!
             */
            posterImageColors(poster: tv?.poster) { (imageColors) in
                self.view.backgroundColor = imageColors?.background
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: imageColors?.primary ?? UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
                self.navigationController?.navigationBar.tintColor = imageColors?.primary
            }
            requestTVDetail(itemId: itemId)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        // Do any additional setup after loading the view.

        navigationItem.largeTitleDisplayMode = .never
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestTVDetail(itemId: String) {
        zmzProvider.request(.resource_item(item_id: itemId)) { result in
            if let tvDetail = handleResponse(nil, type: TVDetail.self, result: result) {
                
            }
        }
    }
    
    func posterImageColors(poster: URL?, imageColors: @escaping ((UIImageColors?) -> Void)) {
        guard let posterCacheURL: URL = poster else {
            return
        }
        if let cacheImage = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: posterCacheURL.absoluteString) {
            let ratio = cacheImage.size.width/cacheImage.size.height
            let r_width: CGFloat = 50
            let scaleDownSize = CGSize(width: r_width, height: r_width/ratio)
            cacheImage.getColors(scaleDownSize: scaleDownSize, completionHandler: imageColors)
        } else {
            KingfisherManager.shared.downloader.downloadImage(with: posterCacheURL, retrieveImageTask: nil, options: nil, progressBlock: nil) { (image, error, _, _) in
                imageColors(image?.getColors())
            }
        }

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
