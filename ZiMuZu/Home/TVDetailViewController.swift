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
import Hue

class TVDetailViewController: UIViewController, UICollectionViewDelegate {
    
    let posterCellID = "TVDetailPosterCell"
    let rateCellID = "TVDetailRateCell"
    var posterColors: (background: UIColor, primary: UIColor, secondary: UIColor, detail: UIColor)? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rightItem: UIBarButtonItem!
    
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
                self.posterColors = imageColors
                self.view.backgroundColor = imageColors?.primary
                self.backItem.tintColor = imageColors?.detail
                self.rightItem.tintColor = imageColors?.detail
                self.statusColorView.backgroundColor = imageColors?.background
                self.view.backgroundColor = imageColors?.background
                UIApplication.shared.statusBarStyle = (imageColors?.background.isDark ?? true) ? .lightContent : .default

            }
            requestTVDetail(itemId: itemId)
        }
    }
    
    var tvDetail: TVDetail? {
        didSet {
            self.collectionView .reloadData()
        }
    }
    
    
    @IBOutlet weak var fakeNavigationBar: UINavigationBar!
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var statusColorView: UIView!
    
    @IBOutlet weak var backItemAction: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
//        fakeNavigationBar.barTintColor = self.view.backgroundColor
        fakeNavigationBar.setBackgroundImage(UIImage(), for: .default)
        fakeNavigationBar.shadowImage = UIImage()
        fakeNavigationBar.backgroundColor = UIColor.clear
        statusColorView.backgroundColor = fakeNavigationBar.backgroundColor
//        fakeNavigationBar.barTintColor = UIColor.clear
        
//        let layout = UICollectionViewFlowLayout()
//        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(UINib.init(nibName: posterCellID, bundle: nil), forCellWithReuseIdentifier: posterCellID)
        collectionView.register(UINib.init(nibName: rateCellID, bundle: nil), forCellWithReuseIdentifier: rateCellID)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backItemAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func requestTVDetail(itemId: String) {
        zmzProvider.request(.resource_item(item_id: itemId)) { result in
            if let tvDetailData = handleResponse(nil, type: TVDetail.self, result: result) {
                self.tvDetail = tvDetailData
            }
        }
    }
    
    func posterImageColors(poster: URL?, imageColors: @escaping (((background: UIColor, primary: UIColor, secondary: UIColor, detail: UIColor)?) -> Void)) {
        guard let posterCacheURL: URL = poster else {
            return
        }
        if let cacheImage = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: posterCacheURL.absoluteString) {
            let ratio = cacheImage.size.width/cacheImage.size.height
            let r_width: CGFloat = 50
            let scaleDownSize = CGSize(width: r_width, height: r_width/ratio)
            imageColors(cacheImage.colors(scaleDownSize: scaleDownSize))
        } else {
            KingfisherManager.shared.downloader.downloadImage(with: posterCacheURL, retrieveImageTask: nil, options: nil, progressBlock: nil) { (image, error, _, _) in
                if let image = image {
                    let ratio = image.size.width/image.size.height
                    let r_width: CGFloat = 50
                    let scaleDownSize = CGSize(width: r_width, height: r_width/ratio)
                    imageColors(image.colors(scaleDownSize: scaleDownSize))
                }
            }
        }
        
    }


}

extension TVDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0: // poster
            let cell: TVDetailPosterCell = collectionView.dequeueReusableCell(withReuseIdentifier: posterCellID, for: indexPath) as! TVDetailPosterCell
            cell.tvDetail = self.tvDetail
            cell.posterColors = self.posterColors
            return cell
        case 1: // rate
            let cell: TVDetailRateCell = collectionView.dequeueReusableCell(withReuseIdentifier: rateCellID, for: indexPath) as! TVDetailRateCell
            cell.tvDetail = self.tvDetail
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rateCellID, for: indexPath)
            return cell
        }

    }
}

extension TVDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0: // poster
            return CGSize(width: collectionView.frame.width, height: 300)
        case 1: // rate
            return CGSize(width: collectionView.frame.width, height: 130)
        default:
            return CGSize(width: collectionView.frame.width, height: 300)
        }
    }

//    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //    @available(iOS 6.0, *)
//    optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
//
//    @available(iOS 6.0, *)
//    optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
}


