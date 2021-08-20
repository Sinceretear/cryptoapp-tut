//
//  HapticManager.swift
//  Tutorial
//
//  Created by Hunter Walker on 8/20/21.
//

import Foundation
import SwiftUI

class HapticManager {

    static private let generator = UINotificationFeedbackGenerator()
    
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }

}
