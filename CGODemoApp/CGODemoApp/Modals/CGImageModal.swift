//
//  CGImageModal.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

class CGImageModal: NSObject {
    
    //MARK: Properties
    var title = ""
    var imageDescription = ""
    var imageHref = ""
    var image: UIImage?

    //MARK: Class functions

    class func imageModal(_ object: Dictionary<String, AnyObject>) -> CGImageModal {
        
        let modal = CGImageModal()
        modal.title = object.stringForKey("title")
        modal.imageDescription = object.stringForKey("description")
        modal.imageHref = object.stringForKey("imageHref")

        return modal
    }
    
    class func imageModalList(_ array: Array<Dictionary<String, AnyObject>>) -> Array<CGImageModal> {
        
        var list = [CGImageModal]()
        for object in array {
            
            let modal = CGImageModal.imageModal(object)
            // skip invalid data i.e. if there is no title and imageHref
            if modal.title.length == 0 && modal.imageHref.length == 0 {
                continue
            }
            list.append(modal)
        }
        
        return list
    }
}
