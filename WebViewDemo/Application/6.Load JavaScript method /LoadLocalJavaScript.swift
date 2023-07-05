//
//  LoadLocalJavaScript.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/27/22.
//

import Foundation
import WebKit

extension ViewController {

    // TODO: - evaluateJavaScript
    func configEvaluateJavaScript() {
        //get html path
        guard let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") else {return}
        let htmlUrl = URL(fileURLWithPath: htmlPath, isDirectory: false)
        self.webView.navigationDelegate = self
        webView.loadFileURL(htmlUrl, allowingReadAccessTo:htmlUrl)
    }
    
    // TODO: - inject Javascript code into webpage (set color and text font size )
    //Check 'readHeader()' in .js file
    func configUserScript() {
        //get html path
        guard let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") else {return}
        let htmlUrl = URL(fileURLWithPath: htmlPath, isDirectory: false)
        
        //inject script
        let contentController = WKUserContentController()
        let userScript  = WKUserScript(source: "readHeader()",
                                       injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
                                       forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        
        //Init webview with configuration
        let config  = WKWebViewConfiguration()
        config.userContentController    = contentController
        
        //give webview configuration
        let configWebView = WKWebView(frame: self.webView.frame, configuration: config)
        self.webView = configWebView
        
        self.view = self.webView! // fill controllers view
        webView.loadFileURL(htmlUrl, allowingReadAccessTo:htmlUrl)
    }
    
    // TODO: - Call native code from JavaScript
    func scriptMessages() {
        
        //get html path
        guard let htmlPath = Bundle.main.path(forResource: "testJavaScript", ofType: "html") else {return}
        let htmlUrl = URL(fileURLWithPath: htmlPath, isDirectory: false)
        
        let userController = WKUserContentController()
        //self : delegate WKScriptMessageHandler
        //name : the key you want the app to listen to.
        userController.add(self, name: "observer")
        let config  = WKWebViewConfiguration()
        config.userContentController = userController
        //give webview configuration
        let configWebView = WKWebView(frame: self.webView.frame, configuration: config)
        self.webView = configWebView
        self.view = self.webView! // fill controllers view
        //load url
        webView.loadFileURL(htmlUrl, allowingReadAccessTo:htmlUrl)
        
    }
    
    // TODO: - Show alert User Infomation
    private func showUserInfo(name : String?,email : String?) {
        
        var messageDesc = "User name : \(name ?? "") have email address : \(email ?? "")"
        var titleAlert  = "User Information"
        if name == "" || email == "" {
            titleAlert  = "Notice"
            messageDesc = "Please input name or email address to show data"
        }
        
        let alertVC = UIAlertController(title: titleAlert, message: messageDesc, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { _ in
            if name != "" && email != "" {
            self.navigationController?.popViewController(animated: true)
            }
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
    }
    
    private func showWelcomeAlert(message : String) {
        let alertVC = UIAlertController(title: "From JavaScript Function evaluateJavaScript :  ", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
        
    }
}
// MARK: - WKScriptMessageHandler
extension ViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //Handle message script here
        if message.name == "observer",let messageBody = message.body as? [String:String] {
            let userName = messageBody["name"],userEmail = messageBody["email"]
            self.showUserInfo(name: userName, email: userEmail)
        }
    }
}

// MARK: - WKNavigationDelegate
extension ViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //run any JavaScript in a WKWebView and read result in swift
        webView.evaluateJavaScript("welcomeSpeech()") { (any,error) in
            print("This is welcomeSpeech return : \(any as! String)")
            self.showWelcomeAlert(message: any as! String)
        }
    }
}
