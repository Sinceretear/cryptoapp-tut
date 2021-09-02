//
//  FileManagerBootcamp.swift
//  Tutorial
//
//  Created by Hunter Walker on 9/2/21.
//

import SwiftUI
import Combine

class LocalFileManagerBootCamp {
    
    static let instance = LocalFileManagerBootCamp()
    let folderName = "MyApp_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path else {
            return
        }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("success creating folder")
            } catch let error {
                print("error creating folder \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("successfully deleted folder")
        } catch let error {
            print("error deleting folder \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.pngData(),
            let path = getPathForImage(name: name) else {
            return "error getting data"
        }
        
        do {
            try data.write(to: path)
            print(path)
            return "success saving"
        } catch let error {
            return "error saving \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("error getting path 0.01")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path) else {
            return "error getting path 🐻"
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            return "successfuly deleted"
        } catch let error {
            return "error deleting image \(error)"
        }
        
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).png") else {
            print("error geting path")
            return nil
        }
        return path
    }
    
}

class FileManagerViewModel: ObservableObject {
    
    @Published var infoMessage: String = ""
    @Published var image: UIImage? = nil
    let imageName: String = "bg"
    let manager = LocalFileManagerBootCamp.instance
    
    
    init() {
        getImageFromAssetsFolder()
        // getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else {return}
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
    
}


struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack {
                    Button(action: {
                        vm.saveImage()
                    }, label: {
                        Text("Save to FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)))
                            .cornerRadius(10)
                    })
                    Button(action: {
                        vm.deleteImage()
                    }, label: {
                        Text("Delete to FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)))
                            .cornerRadius(10)
                    })
                }
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
