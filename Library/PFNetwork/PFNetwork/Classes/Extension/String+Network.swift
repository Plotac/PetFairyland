//
//  String+Network.swift
//  PFNetwork
//
//  Created by Ja on 2023/7/26.
//

import Foundation

extension String {
    var unicodeDescription: String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr: String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as? String ?? ""
        } catch {
            
        }
        return returnStr.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    var toUrl: URL {
        if self.starts(with: "/") {
            return URL(fileURLWithPath: self)
        }
        return URL(string: self) ?? URL(fileURLWithPath: self)
    }
    
    func nsrange(fromRange range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
}
