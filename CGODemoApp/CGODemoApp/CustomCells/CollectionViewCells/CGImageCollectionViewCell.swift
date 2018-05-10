//
//  CGImageCollectionViewCell.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

class CGImageCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var contView: UIView!

    typealias DidTapOnImage = () -> Void
    var onTappingImage: DidTapOnImage?

    override func awakeFromNib() {
         super.awakeFromNib()
        
        avatar.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        tapGestureRecognizer.delegate = self
        avatar.addGestureRecognizer(tapGestureRecognizer)
        
        self.contView.layer.cornerRadius = 8
        self.contView.clipsToBounds = true
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        
        if let onTappingImage = onTappingImage {
            onTappingImage()
        }
    }
}
