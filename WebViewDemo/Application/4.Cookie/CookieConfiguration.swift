//
//  CookieConfiguration.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/16/22.
//

import Foundation
import WebKit

// MARK: - CookieConfiguration
extension WebKitViewController {
    
    // TODO: - Set Cookie
    func setWebCookie() {
        let cookie = HTTPCookie(properties: [.version   : 0,
                                             .name      : "JSESSIONID",
                                             .value     : "E091155CA5E96C30FBE36AF7FC92522A",
                                             .domain    : "approval-dev.appplay.co.kr",
                                             .path      : "/",
                                             .expires   : Date().addingTimeInterval(31536000)])!
        //1.set cookie on HTTPCookie
        webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
        
        
        //2.Store cookie in HTTPCookieStorage
        HTTPCookieStorage.shared.setCookie(cookie)
       
    }
    
    // TODO: - Get Cookie From websiteDataStore Configuration
    //Call this method after setWebCookie if you want to test
    func getCookieFromWebsiteDataStore() {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            let cookieDict = HTTPCookie.requestHeaderFields(with: cookies)
            if let cookieStr = cookieDict["Cookie"] {
                print("Cookie ::: \(cookieStr)")
            }
        }
    }
    
    // TODO: - Get Cookie From Specific URL
    //Call this method after setWebCookie if you want to test
    func getCookieFromSpecificURL(url : URL) {
        if let cookies = HTTPCookieStorage.shared.cookies(for: url) {
            let cookieDict = HTTPCookie.requestHeaderFields(with: cookies)
            if let cookieStr = cookieDict["Cookie"] {
                print("Cookie ::: \(cookieStr)")
            }

        }
    }
}
