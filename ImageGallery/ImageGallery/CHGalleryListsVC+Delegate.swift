//
//  CHGalleryListsVC+Delegate.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 28/09/24.
//

import UIKit

extension CHGalleryListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listFilterGallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CHGalleryListCell.cellIdentifier, for: indexPath) as! CHGalleryListCell
        cell.layoutIfNeeded()
        if let galleryData = self.listFilterGallery {
            cell.cellData = galleryData[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let galleryData = self.listFilterGallery {
            pushModelsScene(with: galleryData[indexPath.item])
        }
    }
    
    // MARK: - Navigation
    
    internal func pushModelsScene(with info: GalleryElement) {
        guard let modelsVC = CHNavigation.getViewController(type: GalleryDetailVC.self,
                                                          identifer: "GalleryDetailVC") else { return }
        let arr = self.listGallery?.filter { $0.albumID == info.albumID }
        modelsVC.listAlbumGallery = arr
        navigationController?.pushViewController(modelsVC, animated: true)
    }
    
}



