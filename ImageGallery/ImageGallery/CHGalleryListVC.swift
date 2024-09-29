//
//  CHGalleryListVC.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 28/09/24.
//

import UIKit

class CHGalleryListVC: UIViewController {

    var listGallery: [GalleryElement]? = []
    var listFilterGallery: [GalleryElement]? = []

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.activityIndicator.hidesWhenStopped = true
        loadMoreData()
    }

    func loadMoreData() {
        activityIndicator.startAnimating()
        LoadDataViewModel().loadData { data, error in
            print("data: \(data ?? [])")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.listGallery? = data ?? []
                self.listFilterGallery = Array(Set(self.listGallery ?? []))
                print("listFilterGallery: \(self.listFilterGallery ?? [])")
                self.collectionView.reloadData()
            }
        }
    }
        
}
