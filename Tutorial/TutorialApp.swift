//
//  TutorialApp.swift
//  Tutorial
//
//  Created by Hunter Walker on 8/15/21.
//

import SwiftUI

@main
struct TutorialApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
