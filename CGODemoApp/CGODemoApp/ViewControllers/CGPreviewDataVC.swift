//
//  CGPreviewDataVC.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

class CGPreviewDataVC: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    //@IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var dataModal : CGImageModal?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let modal = dataModal else {
            return
        }
        
        title = modal.title
        self.descriptionLabel.text = modal.imageDescription
        self.bannerImageView.normalLoad(modal.imageHref)
    }
}
