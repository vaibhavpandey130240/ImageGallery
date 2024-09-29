//
//  CHGalleryDetailVC+Delegate.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 29/09/24.
//

import UIKit

extension GalleryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listAlbumGallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CHGalleryListCell.cellIdentifier, for: indexPath) as! CHGalleryListCell
        cell.layoutIfNeeded()
        if let galleryData = self.listAlbumGallery {
            cell.cellData = galleryData[indexPath.item]
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    
}
