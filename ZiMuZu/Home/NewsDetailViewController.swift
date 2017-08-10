//
//  NewsDetailViewController.swift
//  ZiMuZu
//
//  Created by 张洋威 on 2017/8/10.
//  Copyright © 2017年 zhangyangwei.com. All rights reserved.
//

import UIKit
import CoreText

class NewsDetailViewController: UIViewController {

    var news: News? {
        didSet {
            requestNewsDetail()
        }
    }

    lazy var htmlTextView = { () -> UITextView in
        let textView = UITextView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: kScreenHeight - 100))
        textView.isEditable = false
//        textView.backgroundColor = .clear
        self.view.addSubview(textView)
        return textView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        navigationConfig()

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

                    DispatchQueue.global(qos: .default).async {
                        let attributedText = news.data.content.htmlAttributedString()
                        DispatchQueue.main.async {
                            self.htmlTextView().attributedText = attributedText
                            print("渲染完成: \(CACurrentMediaTime())")
                        }
                    }
//                    self.htmlTextView().attributedText = news.data.content.htmlAttributedString()
                    
                }
                
            } catch {
                print(error)
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

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        print("开始处理字符串: \(CACurrentMediaTime())")
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString( data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return nil }
        print("结束处理字符串: \(CACurrentMediaTime())")
        return html
    }
}
