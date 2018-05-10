//
//  RUtil.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let kAppColor = RGBA(r: 220, g: 107, b: 41, a: 1)

let mainStoryboard =                UIStoryboard(name: "Main", bundle: nil)
let imageSectionStoryboard      = UIStoryboard(name: "ImageSection", bundle: nil)

let kWindowWidth = UIScreen.main.bounds.size.width
let kWindowHeight = UIScreen.main.bounds.size.height

struct AppColor {
    static let darkBlue = RGBA(r: 23, g: 112, b: 171, a: 1) //#1770AB
    static let appColor = darkBlue
    static let lightGray = RGBA(r: 223, g: 227, b: 229, a: 1)
    static let darkGray = RGBA(r: 192, g: 192, b: 192, a: 1)
    static let lightOrange = RGBA(r: 245, g: 165, b: 68, a: 1) //#F5A544
    static let darkOrange = RGBA(r: 171, g: 103, b: 41, a: 1) //#F5A544
    
}

// MARK: - Useful functions

func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: a)
}

func delay(delay: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

