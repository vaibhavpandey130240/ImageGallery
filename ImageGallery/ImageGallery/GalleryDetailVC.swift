//
//  GalleryDetailVC.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 29/09/24.
//

import UIKit

class GalleryDetailVC: UIViewController {
    
    var listAlbumGallery: [GalleryElement]? = []

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
