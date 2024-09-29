//
//  CHNavigation.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 27/09/24.
//

import UIKit

enum StoryBoard: String {
    case main = "Main"
}

struct CHNavigation {
    
    static func getViewController<T: UIViewController>(_ storyboard: StoryBoard = .main, type: T.Type, identifer: String) -> T? {
        
        let storyBoard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: identifer) as? T else { return nil }
        return viewController
    }
}
