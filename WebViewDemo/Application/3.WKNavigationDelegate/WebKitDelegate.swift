//
//  WebKitDelegate.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/16/22.
//

import Foundation
import WebKit

// MARK: -WKNavigationDelegate
extension WebKitViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("............................didFail withError............................")
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("............................didFailProvisionalNavigation............................")
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("............................Webkit did finish loading............................")
        print("............................\(webView.title ?? "")............................")
        self.titleString = webView.title ??  ""
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("............................Webkit navigation response............................")
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("............................Webkit decide policy............................")
        print(navigationAction.request.url?.absoluteString ?? "")
        
        if navigationAction.request.url?.scheme?.lowercased().contains("iwebaction") ?? false {
            
            self.checkActionCode(jsonData: navigationAction.request.url?.absoluteString ?? "") { (actionCode, actionData) in
                DispatchQueue.main.async {
                    self.handleActionCode(webView: webView, actionCode: actionCode, actionData: actionData)
                }
            }
            decisionHandler(.cancel)
        }
        
        else {
            
            if let url = navigationAction.request.url {
                
                let urlScheme = navigationAction.request.url?.scheme ?? ""
                
                if(isItunesURL(url.absoluteString)) {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    
                    decisionHandler(.cancel)
                }
                else if urlScheme != "http" && urlScheme != "https" {
                    if urlScheme.contains("about") {
                        decisionHandler(.allow)
                    }
                    else {
                        DispatchQueue.main.async {
                            if "\(url)".contains("ispmobile") {
                                if self.canExecuteApplication(url) {
                                    //open app
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }else {
                                    //url app store
                                    UIApplication.shared.open(URL(string: "https://itunes.apple.com/kr/app/id369125087?mt=8")!, options: [:], completionHandler: nil)
                                }
                            }else {
                                //open another app
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                        decisionHandler(.cancel)
                    }
                }
                else {
                    decisionHandler(.allow)
                }
            } else {
                decisionHandler(.allow)
            }
        }
    }
}
