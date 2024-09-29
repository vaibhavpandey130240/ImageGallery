//
//  CHGalleryListCell.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 29/09/24.
//

import UIKit

class CHGalleryListCell: UICollectionViewCell {
    
    static let cellIdentifier = String(describing: CHGalleryListCell.self)
    
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var galleryTitleLabel: UILabel!

    var cellData: GalleryElement? {
        didSet {
            if let title = cellData?.title {
                galleryTitleLabel.text = title.capitalized
            }
            if let urlStr = cellData?.url {
                galleryImageView.setImage(with: URL(string: urlStr))
            }
        }
    }
    
}
