//
//  DownloadingImagesBootcamp.swift
//  Tutorial
//
//  Created by Hunter Walker on 9/3/21.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { (model) in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
    
}



struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
