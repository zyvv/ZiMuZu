//
//  NewsDetailViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/10.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import CoreText
import DTCoreText
//import Hero

class NewsDetailViewController: UIViewController, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate {

    var news: News? {
        didSet {
            requestNewsDetail()
        }
    }

    @available(iOS 11.0, *)
    lazy var htmlTextView: DTAttributedTextView = {
        let textView = DTAttributedTextView(frame: view.bounds)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.backgroundColor = .clear
        textView.contentInset = UIEdgeInsetsMake(10, 10, 54, 10)
        textView.contentInsetAdjustmentBehavior = .never
        textView.shouldDrawImages = false;
        textView.shouldDrawLinks = false;
        textView.textDelegate = self
        self.view.addSubview(textView)
        return textView
    }()
    
    let callBackBlock:(DTHTMLElement) -> Void = { element in
        for oneChildElement in element.childNodes {
            guard let oneChildElement: DTHTMLElement = oneChildElement as? DTHTMLElement else {
                return
            }
            if oneChildElement.displayStyle == .inline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize {
                oneChildElement.displayStyle = .block;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    }
    
    lazy var htmlStringAttributeds: [String: Any] = {
        

        let maxImageSize = CGSize(width: view.bounds.size.width - 20, height: view.bounds.size.height - 20)
        return [NSTextSizeMultiplierDocumentOption: NSNumber(floatLiteral: 1.0),
                                                    DTMaxImageSize: NSValue(cgSize: maxImageSize),
                                                    DTDefaultTextColor: UIColor.white,
                                                    DTAttachmentParagraphSpacingAttribute: 25,
                                                    DTDefaultFirstLineHeadIndent:15.0,
                                                    DTDefaultLineHeightMultiplier: 0.8,
//                                                    DTWillFlushBlockCallBack: self.callBackBlock,
                                                    DTDefaultFontSize: NSNumber(floatLiteral: 15.0)]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        navigationConfig()
        extendedLayoutIncludesOpaqueBars = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func requestNewsDetail() {
        zmzProvider.request(.article(id: (news?.id)!)) { result in
            do {
                if case let .success(response) = result {
                    let news = try JSONDecoder().decode(NewsDetail.self, from: response.data)
                    guard let data = news.content.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return }
                    let attributedString = NSAttributedString(htmlData: data, options: self.htmlStringAttributeds, documentAttributes: nil)
                    DispatchQueue.main.async {
                        if #available(iOS 11.0, *) {
                            self.htmlTextView.attributedString = attributedString
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    
    // MARK: - DTAttributedTextContentViewDelegate
    func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!, viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
        if attachment.isKind(of: DTImageTextAttachment.self) {
            let imageView = DTLazyImageView(frame: frame)
            imageView.delegate = self
            imageView.url = attachment.contentURL
            return imageView
        }
        return UIView()
    }
    
    // MARK: - DTLazyImageViewDelegate
    func lazyImageView(_ lazyImageView: DTLazyImageView!, didChangeImageSize size: CGSize) {
        let url = lazyImageView.url
        let imageSize = size
        let predicate = NSPredicate(format: "contentURL == %@", url! as NSURL)
        
        var didUpdate = false
        if #available(iOS 11.0, *) {
            for oneAttachment in self.htmlTextView.attributedTextContentView.layoutFrame.textAttachments(with: predicate) {
                guard let oneAttachment: DTTextAttachment = oneAttachment as? DTTextAttachment else {
                    return
                }
                if oneAttachment.originalSize.height == 0 {
                    oneAttachment.originalSize = imageSize
                    didUpdate = true
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        if didUpdate {
            DispatchQueue.main.async {
                if #available(iOS 11.0, *) {
                    self.htmlTextView.relayoutText()
                } else {
                    // Fallback on earlier versions
                }
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
//
//extension String {
//    func htmlAttributedString() -> NSAttributedString? {
//        print("开始处理字符串: \(CACurrentMediaTime())")
//        guard let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return nil }
//        guard let html =
//        print("结束处理字符串: \(CACurrentMediaTime())")
//        return html
//    }
//}

