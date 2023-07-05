//
//  CONTENT_VM.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/29/22.
//

import Foundation

class ContentVM {
    
    var recContent  : [CONTENT]?
    func loadContent() {
        recContent = [CONTENT(title: "1.Init WebView",type: CONTENT_TYPE.InitWebView),
                      CONTENT(title: "2.LoadURL",type: CONTENT_TYPE.LoadURL),
                      CONTENT(title: "3.WKNavigationDelegate",type: CONTENT_TYPE.WKNavigationDelegate),
                      CONTENT(title: "4.Cookie",type: CONTENT_TYPE.Cookie),
                      CONTENT(title: "5.Load Local HTML",type: CONTENT_TYPE.LoadLocalHTML),
                      CONTENT(title: "  - Load Local HTMLString",type: CONTENT_TYPE.LoadLocalHTMLString),
                      CONTENT(title: "6.Load JavaScript method",type: CONTENT_TYPE.LoadJavaScriptMethod),
                      CONTENT(title: "  - Inject JavaScript code into webpage (WKUserScript)",type: CONTENT_TYPE.InjectJavaScriptCode),
                      CONTENT(title: "  - call back from JavaScript to Swift (WKScriptMessageHandler)",type: CONTENT_TYPE.CallBackFromJavaScript)]
    }
}
