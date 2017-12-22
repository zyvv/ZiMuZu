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

//        collectionView.register(UINib.init(nibName: posterCellID, bundle: nil), forCellWithReuseIdentifier: posterCellID)
//        collectionView.register(UINib.init(nibName: rateCellID, bundle: nil), forCellWithReuseIdentifier: rateCellID)
//        collectionView.register(UINib.init(nibName: alertCellID, bundle: nil), forCellWithReuseIdentifier: alertCellID)
//        collectionView.register(UINib.init(nibName: descCellID, bundle: nil), forCellWithReuseIdentifier: descCellID)
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

/*
extension TVDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
        case 2:
            let cell: TVDetailAlertCell = collectionView.dequeueReusableCell(withReuseIdentifier: alertCellID, for: indexPath) as! TVDetailAlertCell
            return cell
        case 3:
            let cell: TVDetailDescCell = collectionView.dequeueReusableCell(withReuseIdentifier: descCellID, for: indexPath) as! TVDetailDescCell
            cell.tvDetail = self.tvDetail
            cell.updateDescCellHeight {
                let indexPath = NSIndexPath(item: 3, section: 0)
                let context = UICollectionViewFlowLayout.invalidationContextClass
//                let context = self.collectionView.collectionViewLayout.inv
            }
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
            return CGSize(width: collectionView.frame.width, height: 135)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 30)
        case 3:
            return CGSize(width: collectionView.frame.width, height: 100)
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
}
*/

