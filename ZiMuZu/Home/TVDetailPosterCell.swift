//
//  TVDetailPosterCell.swift
//  ZiMuZu
//
//  Created by gakki's vi~ on 2017/12/20.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import ShadowImageView
import Kingfisher
import UIImageColors
import Hue

class TVDetailPosterCell: UICollectionViewCell {

    @IBOutlet weak var posterView: ShadowImageView!
    
    var posterColors: (background: UIColor, primary: UIColor, secondary: UIColor, detail: UIColor)? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    var tvDetail: TVDetail? {
        didSet {
            if let _tvDetail = tvDetail {
                let imageURL = ((_tvDetail.resource?.poster_n) != nil) ? (_tvDetail.resource?.poster_n)! : (_tvDetail.resource?.poster_b)!
                KingfisherManager.shared.downloader.downloadImage(with: imageURL, retrieveImageTask: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
//                    if let _image = image {
                        self.posterView.image = image
//                    }
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let colors: [UIColor] = [posterColors?.background ?? UIColor(hex: "#0f1011"), UIColor(hex: "#0f1011")]
        let gradient = colors.gradient { (gradient) -> CAGradientLayer in
            gradient.locations = [0.0, 1.0]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            return gradient
        }
        gradient.timeOffset = 0
        gradient.bounds = self.bounds
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }


}
