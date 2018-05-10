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
    @IBOutlet weak var descriptionField: UITextView!
    
    var dataModal : CGImageModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let modal = dataModal else {
            return
        }
        
        title = modal.title
        self.descriptionField.text = modal.imageDescription
        self.bannerImageView.normalLoad(modal.imageHref)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
