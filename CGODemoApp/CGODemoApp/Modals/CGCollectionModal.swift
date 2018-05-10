//
//  CGCollectionModal.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

class CGCollectionModal: NSObject {

    //MARK: Properties
    var title: String
    var rows: Array<CGImageModal>

    //MARK: Init
    init(text: String) {
        title = text
        rows = []
    }
    
    convenience init(object: Dictionary<String, AnyObject>) {
        self.init(text: object.stringForKey("title"))

        if let rows = object["rows"] as? Array<Dictionary<String, AnyObject>> {
            self.rows = CGImageModal.imageModalList(rows)
        }
     }
}
