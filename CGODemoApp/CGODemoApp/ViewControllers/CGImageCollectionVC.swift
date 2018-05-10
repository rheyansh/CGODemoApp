//
//  CGImageCollectionVC.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

class CGImageCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSourceArray = [CGImageModal]()
    var refresher:UIRefreshControl!

    //MARK:- UIViewController Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    //MARK: Private functions
    private func initialSetup() {
        loadDataFromServer()
        
        self.collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        // setup refresh control
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }
    
    @objc private func refreshData() {
        stopRefresher()
    }
    
    private func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    //MARK: UICollectionViewDataSource and Delegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return dataSourceArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CGImageCollectionViewCell", for: indexPath) as! CGImageCollectionViewCell
        
        let modal = self.dataSourceArray[indexPath.row]
        cell.avatar.normalLoad(modal.imageHref)
        
        cell.onTappingImage = {
            () -> Void in
            let previewDataVC = self.storyboard?.instantiateViewController(withIdentifier: "CGPreviewDataVC") as! CGPreviewDataVC
            previewDataVC.dataModal = modal
            self.navigationController?.pushViewController(previewDataVC, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = self.collectionView.frame.size.width/4
        var height = width
        
        return CGSize(width: width, height: height)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK:- Segues

    //MARK:- Web api section
    
    private func loadDataFromServer() {
        
        ServiceHelper.request(params: [:], method: .get, apiName: "facts.json") { (response, error, httpCode) in
            self.stopRefresher()
            if let error = error {
                AlertController.alert(title: error.localizedDescription)
            } else {
             
                if let infoDictionary = response as? Dictionary<String, AnyObject> {
                    let collectionModal = CGCollectionModal(object: infoDictionary)
                    self.title = collectionModal.title
                    self.dataSourceArray = collectionModal.rows
                    self.collectionView.reloadData()
                }
            }
        }
    }

    //MARK:- Memory handling
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
