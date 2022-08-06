//
//  WebViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/05.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

class WebViewController: UIViewController {
    
    static let identifer = "WebViewController"
    
    var videoKey = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nvDesign()
        openWebPage(key: videoKey)
    }
    
    func nvDesign() {
        let item = navigationItem
        item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backToTmdb))
        item.leftBarButtonItem?.tintColor = .blue
    }
    
    @objc func backToTmdb() {
        dismiss(animated: true)
    }
    

    func openWebPage(key: String) {
        //유효한 URL인지 확인
        guard let url = URL(string: EndPoint.youtubeURL + "\(key)") else {
            print(key, "dssdsdsdsdsd")
            print("Invaild URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        //skeletonView library
    }
    
    
    
    

}
