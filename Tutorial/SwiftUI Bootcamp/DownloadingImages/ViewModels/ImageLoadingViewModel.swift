//
//  ImageLoadingViewModel.swift
//  Tutorial
//
//  Created by Hunter Walker on 9/3/21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    //for images in current session
    let manager = PhotoModelCacheManager.instance
    
    //for images that need to be saved to device
    //let manager = PhotoModelFileManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("getting saved image")
        } else {
            downloadImage()
            print("downloading image now!")
        }
    }
    
    
    func downloadImage() {
        guard let url = URL(string: urlString) else {
            isLoading = false
            return}
        URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let image = returnedImage else {return}
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
        
    }
    
}
