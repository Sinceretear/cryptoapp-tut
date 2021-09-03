//
//  PhotoModel.swift
//  Tutorial
//
//  Created by Hunter Walker on 9/3/21.
//

import Foundation
import Combine


/*
 https://jsonplaceholder.typicode.com/photos
 */

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
