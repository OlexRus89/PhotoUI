//
//  PhotosUIConfiguration.swift
//  PhotoUI
//
//  Created by Алексей Свидницкий on 12.08.2022.
//

import SwiftUI
import PhotosUI
import CoreData

//struct ImagePicker: UIViewControllerRepresentable {
//    func makeCoordinator() -> Coordinator {
//        return ImagePicker.Coordinator(parent: self)
//    }
//
//    @Binding var image: UIImage?
//    @Binding var picker: Bool
//
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//        let picker = PHPickerViewController(configuration: config)
//
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//
//    }
//
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        var parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            for img in results {
//                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
//                    img.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
//                        guard let image = image else {
//                            print(error)
//                            return
//                        }
//
//                        self.parent.image = image as! UIImage
//                        self.parent.picker = false
//                    }
//                } else {
//                    print("Error")
//                }
//            }
//        }
//    }
//}

struct PhotoPicker: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                let a = info[.imageURL]
                let menager = LocalFileManager.instance
                menager.saveImage(image: image, name: "avatar")
                photoPicker.image = image
            } else {
                
            }
            picker.dismiss(animated: true)
        }
    }
}
