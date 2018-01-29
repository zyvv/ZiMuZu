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
import IGListKit

class TVDetailViewController: UIViewController, ListAdapterDataSource {
    
    let posterCellID = "TVDetailPosterCell"
    let rateCellID = "TVDetailRateCell"
    let alertCellID = "TVDetailAlertCell"
    let descCellID = "TVDetailDescCell"
    
    var posterColors: (background: UIColor, primary: UIColor, secondary: UIColor, detail: UIColor)? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rightItem: UIBarButtonItem!
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    var tv: TV? {
        didSet {
            guard let itemId = tv?.id else {
                return
            }
            self.title = tv?.cnname
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
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var fakeNavigationBar: UINavigationBar!
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var statusColorView: UIView!
    
    @IBOutlet weak var backItemAction: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()

        fakeNavigationBar.setBackgroundImage(UIImage(), for: .default)
        fakeNavigationBar.shadowImage = UIImage()
        fakeNavigationBar.backgroundColor = UIColor.clear
        statusColorView.backgroundColor = fakeNavigationBar.backgroundColor
        
        adapter.collectionView = collectionView
        adapter.dataSource = self

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
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        if let _tvDetail = tvDetail {
            return [_tvDetail, _tvDetail, _tvDetail] as [ListDiffable]
        }
        return []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = TVDetailSectionController()
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    
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

