//
//  MainVC.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/29/22.
//

import UIKit

enum CONTENT_TYPE {
    case InitWebView
    case LoadURL
    case WKNavigationDelegate
    case Cookie
    case LoadLocalHTML
    case LoadLocalHTMLString
    case LoadJavaScriptMethod
    case InjectJavaScriptCode
    case CallBackFromJavaScript
}

class MainVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let contentVM = ContentVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        contentVM.loadContent()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden =  true
    }

    private func callWebWithParam() {
        
        let vc  = UIStoryboard(name: "WebKitSB", bundle: nil).instantiateViewController(withIdentifier: "WebKitViewController") as! WebKitViewController
        let  url        = "https://biztrip-dev.appplay.co.kr/biztrip_mpoint_gate.act"
        let jsonString  = Share.callBizPoint().encodeToJsonString
        vc.urlStr       = "\(url)?JSONData=\(jsonString)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*/ ---Action Code Flow
     1.LoadWeb  (Note : don't call addHeader() for test  Action code 1004 -> Session timeout)
     2.WKNavigationDelegate : decidePolicyFor navigationAction
     3.checkActionCode  (Check Action code from web navigation action)
     4.handleActionCode (Get ActionCode and Handle It )
     5.processActionCode (Action code activities)
     */
    private func callWebActionCode() {
        
        let  domainUrl  = "https://approval-dev.appplay.co.kr//MApprGateway/APPROVAL_DTL_101.act"
        let param       = "APPR_SEQ_NO=856721&POPUP_YN=N"
        let vc          = UIStoryboard(name: "WebKitSB", bundle: nil).instantiateViewController(withIdentifier: "WebKitViewController") as! WebKitViewController
        vc.urlStr       = domainUrl
        vc.param        = param
        vc.webKitType   = .COOKIE_WEBVIEW   //For set webCookie and action code
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentVM.recContent?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.menuTitleLabel.text = self.contentVM.recContent?[indexPath.row].title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc  = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        guard let type = self.contentVM.recContent?[indexPath.row].type else {return}
        vc.type = type
        switch type {
        case.LoadURL :
            /*-Load url with param*/
            self.callWebWithParam()
        case.WKNavigationDelegate,.Cookie :
            /*-For test navigation delegate , addHeader,set cookie*/
            self.callWebActionCode()
        default :
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
