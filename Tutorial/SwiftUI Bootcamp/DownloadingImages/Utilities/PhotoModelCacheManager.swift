//
//  PhotoModelCacheManager.swift
//  Tutorial
//
//  Created by Hunter Walker on 9/3/21.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
    
    static let instance = PhotoModelCacheManager()
    
    private init() {
        
    }
    
    var PhotoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024*1024*200 // 200mb
        return cache
    }()
   
    func add(key: String, value: UIImage) {
        PhotoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return PhotoCache.object(forKey: key as NSString)
    }
    
}
