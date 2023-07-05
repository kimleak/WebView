//
//  WebKitViewController.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/12/22.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var webKitType          = WebKitType.General
    var savedActionCode     = [String:Set<String>]()
    var urlStr              : String!
    var param               : String?
    var urlRequest          : URLRequest?
    
    var titleString = "" {
        didSet {
            self.title = titleString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBaseWebview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden =  false
        
    }
    // TODO: - set up webview
    func setupBaseWebview() {
        
        switch webKitType {
        case .COOKIE_WEBVIEW:
            //1.Call this method if you want to test cookie  and action code
            self.setWebCookie()
        default :break
        }
        
        self.webView.navigationDelegate = self
        
        if !urlStr.isEmpty {
            self.loadUrl()
        }
    }
    
    // TODO: - Load URL
    func loadUrl() {
        let url = URL(string: urlStr)
        guard let urlToLoad = url else {
            return
        }
        
        urlRequest = URLRequest(url: urlToLoad)
        
        //- setup param
        if let myParam = self.param {
            urlRequest?.httpMethod = "POST"
            urlRequest?.httpBody = myParam.data(using: .utf8)
        }
        
        //Add header 
        self.addHeader()
        
        _ = webView.load(urlRequest!)
    }

    // TODO: - setup header
    func addHeader() {
        
        //-.Get cookie from from specific URL
        //-.Add Cookie to HeaderField
        if let url = urlRequest?.url, let cookies = HTTPCookieStorage.shared.cookies(for: url) {
            let cookieDict = HTTPCookie.requestHeaderFields(with: cookies)
            if let cookieStr = cookieDict["Cookie"] {
                urlRequest?.addValue(cookieStr, forHTTPHeaderField: "Cookie")
            }
        }
        
        //-Add UserAgent
        let getUserAgent = "Mozilla/5.0 (iPhone; U; CPU iPhone OS \(UIDevice.current.systemVersion) like Mac OS X; ko-kr) AppleWebKit/605.1.15 (KHTML, like Gecko)"
        urlRequest?.addValue(getUserAgent, forHTTPHeaderField: "User-Agent")
        
        //Content type for supporting HTML request
        urlRequest?.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
}







