//
//  ViewController.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/8/22.
//

import UIKit
import WebKit
class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var type = CONTENT_TYPE.InitWebView
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden =  false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch type {
        case .InitWebView:
            /*-Init webView*/
            self.initWebView()
        case .LoadLocalHTML:
            /*-LoadFileURL*/
            self.loadHTMLFile()
        case .LoadLocalHTMLString:
            /*-Load Local HTMLString*/
            self.loadLocalHTMLString()
        case.LoadJavaScriptMethod :
            /*-evaluateJavaScript*/
            self.configEvaluateJavaScript()
        case.InjectJavaScriptCode :
            /*-inject Javascript code into webpage*/
            self.configUserScript()
        case.CallBackFromJavaScript :
            /*-Call native code from JavaScript*/
            self.scriptMessages()
        default : break
        }
        
        
    }

    // TODO: - Load URL
    private func initWebView() {
        let url = URL(string: "https://www.kosign.com.kh/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

}

