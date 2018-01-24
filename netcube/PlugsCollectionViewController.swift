//
//  PlugsCollectionViewController.swift
//  netcube
//
//  Created by fran on 2/4/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import CoreData
private let reuseIdentifier = "deviceCollectionCell"

class PlugsCollectionViewController: CoreDataCollectionViewController {
    
    override init(fetchedResultsController fc: NSFetchedResultsController<NSFetchRequestResult>, layout: UICollectionViewLayout) {
        super.init(fetchedResultsController: fc, layout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.title = "Inicio"
        
        let nib = UINib(nibName: "DeviceCollectionViewCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: "deviceCollectionCell")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDevice))
        
        let startColor = UIColor(red: 24/255, green: 40/255, blue: 72/255, alpha: 1)
        let endColor = UIColor(red: 75/255, green: 108/255, blue: 183/255, alpha: 1)
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.backgroundView = GradientView()
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DeviceCollectionViewCell
        let device = items()[indexPath.item]
        cell.deviceNameLabel.text = device["name"]
        cell.deviceImageView.image = UIImage(named:device["image"]!)
        if indexPath.item == 1 {
            cell.alpha = 0.5
        }
        return cell
    }

    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Navigator.moveToDeviceViewControllerWith(self.items()[indexPath.item],navigationController: self.navigationController!,indexPath: indexPath)
    }
    
    func addDevice() {
        
        let addDeviceVC = ESPViewController()
        
        self.navigationController?.pushViewController(addDeviceVC, animated: true)
        
    }
    
    
    func items() -> [[String:String]] {
        
        return [
            ["name":"Enchufe salón","image": "plug","MAC":"D8:FB:5E:2A:24:7E","IP_ADDRESS":"192.168.1.36"],["name":"Calefacción","image":"plug","MAC":"D8:FB:5E:2A:24:7E","IP_ADDRESS":"192.168.1.36"],
                ["name":"Aire","image":"Air","MAC":"D8:FB:5E:2A:24:7E","IP_ADDRESS":"192.168.1.36"],
                ["name":"Luz cocina","image":"switch_on","MAC":"D8:FB:5E:2A:24:7E","IP_ADDRESS":"192.168.1.36"],
                ["name": "Torre de música","image": "play-button","MAC":"D8:FB:5E:2A:24:7E","IP_ADDRESS":"192.168.1.36"]
]
        
    }
}


extension PlugsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 108, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 28, left: 28, bottom: 28, right: 28)
    }
}
