//
//  ImagePicker.swift
//  WhatDoUEat
//
//  Created by 김태호 on 2022/08/31.
//

import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var isPresented : Bool
    @Binding var selectedImage : Data
    var sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(picker: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.sourceType  = sourceType
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var picker : ImagePicker
        init(picker : ImagePicker) {
            self.picker = picker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.picker.isPresented.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                fatalError("Picker didn't have an original image.")
            }
            
            let data = selectedImage.pngData()
            self.picker.selectedImage = data!
            self.picker.isPresented.toggle()
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.classifyImage(selectedImage)
            }
        }
    }
}

extension ImagePicker {
    
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }
}
