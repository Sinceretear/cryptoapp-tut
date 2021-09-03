//
//  TutorialApp.swift
//  Tutorial
//
//  Created by Hunter Walker on 8/15/21.
//

import SwiftUI

@main
struct TutorialApp: App {
    
//    @StateObject private var vm = HomeViewModel()
//    @State private var showLaunchView: Bool = true
//
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
//    }
    
    var body: some Scene {
        WindowGroup {
//            ZStack {
//                NavigationView{
                    DownloadingImagesBootcamp()
//                        .navigationBarHidden(true)
//                }
//                .environmentObject(vm)
//                ZStack {
//                    if showLaunchView {
//                        LaunchView(showLaunchView: $showLaunchView)
//                            .transition(.move(edge: .leading))
//                    }
//                }.zIndex(2.0)
//            }
        }
    }
}
