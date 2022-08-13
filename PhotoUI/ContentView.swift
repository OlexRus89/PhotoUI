//
//  ContentView.swift
//  PhotoUI
//
//  Created by Алексей Свидницкий on 12.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State var image: UIImage? = nil
    @State var picker = false
    
    @State var test = "file:///private/var/mobile/Containers/Data/Application/4614EE61-199E-488D-9B3E-34B39396B64D/tmp/14CF065B-C293-4B68-BF5B-4F885A950EA6.png"

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)

            Text("Hello, world!")
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .cornerRadius(30)
                    .shadow(radius: 5)
                    .padding(.horizontal, 7)
            }
            Button {
                picker.toggle()
            } label: {
                Text("Выбрать фотографию")
            }

        }
        .sheet(isPresented: $picker) {
            PhotoPicker(image: $image)
                .padding(.vertical, 10)
        }
        .onAppear {
            let menager = LocalFileManager.instance
            self.image = menager.getImage(name: "avatar")
        }
    }
}

class LocalFileManager {
    static var instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1.0), let  path = getPathForImage(name: name) else {
            print("Error getting data.")
            return
        }
        
        do {
            try data.write(to: path)
            print("Success saving")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard  let path = getPathForImage(name: name)?.path, FileManager.default.fileExists(atPath: path) else {
            print("Getting error")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("\(name).png") else {
            print("Error")
            return nil
        }
        
        return path
    }
}
