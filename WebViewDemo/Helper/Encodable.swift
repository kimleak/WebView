//
//  Encodable.swift
//  WebViewDemo
//
//  Created by Thorn Loemkimleak on 9/12/22.
//

import Foundation

extension Encodable {
   
    var encodeToJsonString: String {
        let jsonEncoder = JSONEncoder()
        let jsonData    = try? jsonEncoder.encode(self)
        let jsonString  = String(data: jsonData ?? Data(), encoding: .utf8) ?? ""
        return jsonString.addingPercentEncoding(withAllowedCharacters: .symbols) ?? ""
    }
}
