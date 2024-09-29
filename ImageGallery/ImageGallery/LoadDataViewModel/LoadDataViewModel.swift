//
//  LoadDataViewModel.swift
//  ImageGallery
//
//  Created by Vaibhav Pandey on 27/09/24.
//

import Foundation

class LoadDataViewModel {
    
    typealias LoadDataResult = ((_ data: [GalleryElement]?, _ error: Error?) -> Void)
    
    // MARK: - Private Properties
    
    private lazy var datasource: [GalleryElement] = []
    

    private var dataTask: URLSessionDataTask?
    
    private lazy var networkManager = CHNetworkManager()
    
    private var failedTaskCount: Int = 0
    
    
    // MARK: - De-Initializer

    deinit {
        dataTask?.cancel()
    }

    
    // MARK: - Load Data Methods
    
    func loadData(completionHandler: @escaping LoadDataResult) {
        
        let urlStr = "https://jsonplaceholder.typicode.com/photos"
        
        guard let url = URL(string: urlStr) else { return }
        
        dataTask = networkManager.dataTaskFromURL(url,
                                                  completion: { (result: Result<[GalleryElement]>) in
            switch result {
            case .success(let response):
                self.datasource = response[0]
                completionHandler(self.datasource, nil)
                
            case .failure(let error):
                self.failedTaskCount += 1
                completionHandler(nil, error)
            }
        })
        
        dataTask?.resume()
    }
}
