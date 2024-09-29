//
//  UIView+Extension.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 27/09/24.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
}

extension UIImageView {
    private static var taskKey = 0
    private static var urlKey = 0

    private var savedTask: URLSessionTask? {
        get { objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var savedUrl: URL? {
        get { objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func setImage(with url: URL?) {
        // cancel prior task, if any

        weak var oldTask = savedTask
        savedTask = nil
        oldTask?.cancel()

        guard let url else { return }

        // check cache

        if let cachedImage = ImageCache.shared.image(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }

        // download

        savedUrl = url
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.savedTask = nil

            // error handling

            if let error {
                // don't bother reporting cancelation errors

                if (error as? URLError)?.code == .cancelled {
                    return
                }

                print(error)
                return
            }

            guard let data, let downloadedImage = UIImage(data: data) else {
                print("unable to extract image")
                return
            }

            ImageCache.shared.save(image: downloadedImage, forKey: url.absoluteString)

            if url == self?.savedUrl {
                DispatchQueue.main.async {
                    self?.image = downloadedImage
                }
            }
        }

        // save and start new task

        savedTask = task
        task.resume()
    }
}

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?

    static let shared = ImageCache()

    private init() {
        // make sure to purge cache on memory pressure

        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
