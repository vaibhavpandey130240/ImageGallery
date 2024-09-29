//
//  GalleryModel.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 28/09/24.
//

// MARK: - GalleryElement
struct GalleryElement: Codable, Hashable, Equatable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

func ==(left:GalleryElement, right:GalleryElement) -> Bool {
    return left.albumID == right.albumID
}


typealias Gallery = [GalleryElement]
