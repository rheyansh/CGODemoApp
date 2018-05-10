//
//  GeneralExtensions.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

// MARK:- Dictionary Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

extension Dictionary {
    
    func stringForKey(_ key: Key) -> String {
        if let string = self[key] as? String {
            return string
        }
        
        return ""
    }
    
    func toData() -> Data {
        return try! JSONSerialization.data(withJSONObject: self, options: [])
    }
    
    func toJsonString() -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        return jsonString
    }
}

// MARK:- UIImageView Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

extension UIImageView {
    
    //@@@@ Load from actual url string
    
    func normalLoad(_ string: String) {
        
        if let url = URL(string: string) {
            //self.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder")!, options: .refreshCached)
            self.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder")!)
        } else {
            self.image = UIImage(named: "placeholder")!
        }
    }
}

