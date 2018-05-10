//
//  Debug.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

// Logger for debug

final class Debug {
    
    static var isEnabled = true
    
    static func log(_ msg: @autoclosure () -> String = "", _ file: @autoclosure () -> String = #file, _ line: @autoclosure () -> Int = #line, _ function: @autoclosure () -> String = #function) {
        if isEnabled {
            let fileName = file().components(separatedBy: "/").last ?? ""
            print("\n<======================[Debug]======================>\n")
            print("[File: \(fileName)] [line: \(line())]\n[Function: \(function())]\n\(msg())")
            //print(["\(fileName):\(line())]🍀🍀🍀: \(function()) \(msg())")
        }
    }
}
