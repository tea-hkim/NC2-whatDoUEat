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
    @Binding var predictionVegetable : String
    
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
        let imagePredictor = ImagePredictor()
        var picker : ImagePicker
        init(picker : ImagePicker) {
            self.picker = picker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.picker.isPresented.toggle()
        }
        
        private func classifyImage(_ image: UIImage) {
            do {
                try self.imagePredictor.makePredictions(for: image,
                                                        completionHandler: imagePredictionHandler)
            } catch {
                print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
            }
        }
        
        private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
            guard let predictions = predictions else { return }

            print(formatPredictions(predictions))
        }
        
        private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
            // Vision sorts the classifications in descending confidence order.
            let topPredictions: [String] = predictions.prefix(1).map { prediction in
                var name = prediction.classification
                print(name)
                // For classifications with more than one name, keep the one before the first comma.
                if let firstComma = name.firstIndex(of: ",") {
                    name = String(name.prefix(upTo: firstComma))
                }

                return "\(name) - \(prediction.confidencePercentage)%"
            }
            return topPredictions
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
