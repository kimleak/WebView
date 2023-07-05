//
//  LoadLocalHTML.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/22/22.
//

import Foundation
import WebKit

extension ViewController {
    
    // TODO: - LoadFileURL
    func loadHTMLFile() {
        
        //get html path
        guard let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") else {return}
        let htmlUrl = URL(fileURLWithPath: htmlPath, isDirectory: false)
        webView.loadFileURL(htmlUrl, allowingReadAccessTo:htmlUrl)

    }
    
    // TODO: - Load Local HTMLString
    func loadLocalHTMLString() {
        webView.loadHTMLString("<h1 style=color:red> Hello world </h1>", baseURL: nil)
    }
}
