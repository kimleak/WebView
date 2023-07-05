//
//  Share.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/12/22.
//

import Foundation

struct BIZ_POINT        : Encodable {
    var PTL_ID          : String?
    var CHNL_ID         : String?
    var USE_INTT_ID     : String?
    var USER_ID         : String?
    var USER_NM         : String?
    var PTL_URL         : String?
}

struct Share {
    static func callBizPoint() -> BIZ_POINT {
        
        let PTL_ID      = "PTL_51"
        let CHNL_ID     = "CHNL_1"
        let USE_INTT_ID = "UTLZ_1709060902735"
        let USER_ID     = "simdemo01t"
        let USER_NM     = "심관리자s"
        let PTL_URL     = "https://mg-dev.bizplay.co.kr/"
        
        let biz_point = BIZ_POINT(PTL_ID: PTL_ID, CHNL_ID: CHNL_ID, USE_INTT_ID: USE_INTT_ID, USER_ID: USER_ID, USER_NM: USER_NM, PTL_URL: PTL_URL)
        
        return biz_point
        
    }
}
