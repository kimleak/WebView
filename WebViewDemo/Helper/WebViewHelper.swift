//
//  WebViewHelper.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/12/22.
//

import Foundation
import WebKit
import UIKit


enum WebKitType {
    case General
    case CREATE_WEBVIEW
    case COOKIE_WEBVIEW
}
enum ActionCode : String {
    case empty      = ""
    case ac_1004    = "1004"  // (session timeout)
    // FIXME: - Handle more action code here if you want to practice ^^
    
}
extension WebKitViewController {
    
    // TODO: - Check Action code from web navigation action
    func checkActionCode(jsonData:String,completion: @escaping (String,[String:Any]?) -> Void) {
        
        if jsonData.lowercased().contains("iwebaction") {
            var actionDic: [String: Any]?
            
            let compJson = jsonData.components(separatedBy: ":")
            let scheme = compJson.first ?? ""
            let jsonString = jsonData.replacingOccurrences(of: "\(scheme):", with: "")
            actionDic = jsonString.removingPercentEncoding?.toDictionary
            
            if jsonData.lowercased().contains("iwebactionssotoken"){
                completion("token", actionDic!)
            }
            else {
                if let actionDic = actionDic {
                    guard let actionCodes = (actionDic["_action_code"] as? String)?.components(separatedBy: "|") else {
                        return
                    }
                    if let actionData = actionDic["_action_data"] as? [String:Any] {
                        for actionCode in actionCodes {
                            completion(actionCode,actionData)
                        }
                    }else if let actionData = actionDic["_action_data"] as? String {
                        for actionCode in actionCodes {
                            let dic = [
                                "RESP_CD" : actionData,
                                "RESP_NM" : actionData
                            ]
                            completion(actionCode, dic)
                        }
                    }
                    else {
                        for actionCode in actionCodes {
                            completion(actionCode,nil)
                        }
                    }
                }
            }
            
        }
    }
    
    // TODO: - Get and Handle ActionCode
    func handleActionCode(webView: WKWebView, actionCode:String,actionData : [String: Any]?) {
        let actionCD = ActionCode(rawValue: actionCode) ?? .empty
        print("::::: Action Code :::::")
        print(actionCode)
        print("::::: Action Data :::::")
        print(actionData ?? "")
        let urlString = webView.url?.absoluteString ?? ""
        
        //Store action code
        if var codes = savedActionCode[urlString] {
            codes.insert(actionCode)
            savedActionCode[urlString] = codes
        }
        else {
            savedActionCode[urlString] = [actionCode]
        }
        
        self.processActionCode(actionCode: actionCD, actionData: actionData)

    }
    
    // TODO: - Check if iTunesURL
    func isItunesURL(_ urlString: String) -> Bool {
        return isMatch(urlString, "\\/\\/itunes\\.apple\\.com\\/")  || isMatch(urlString, "\\/\\/apps\\.apple\\.com\\/")
    }
    
    func isMatch(_ urlString: String, _ pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let result = regex.matches(in: urlString, options: [], range: NSRange(location: 0, length: urlString.count))
        return result.count > 0
    }
    
    func canExecuteApplication(_ urlScheme:URL) -> Bool {
        return UIApplication.shared.canOpenURL(urlScheme)
    }
    
    // TODO: - Action code activities
    func processActionCode(actionCode: ActionCode, actionData: [String : Any]?) {
        switch actionCode {
        case .empty: break
        case.ac_1004 : self.sessionTimeOutError()
            
        }
    }
    
    // TODO: - Handle session timeout
    func sessionTimeOutError() {
        let alert = UIAlertController(title: "", message: "Session Timeout", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
