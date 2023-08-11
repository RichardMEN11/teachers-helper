//
//  ImageViewWithPicker.swift
//  teachers-helper
//
//  Created by Richard Menning on 11.08.23.
//

import SwiftUI
import UIKit
import AVFoundation

struct ImageViewWithPicker: View {
    @State private var showImagePicker = false
    @State private var image: Image?
    
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            } else {
                Text("No Image Selected")
                    .foregroundColor(.gray)
            }
            
            Button("Select Image") {
                showImagePicker = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image, onDismiss: onDismiss)
            }
        }
        .padding()
    }
    
    func onDismiss() {
        print("dismissed")
    }
}

struct ImageViewWithPicker_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewWithPicker()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
    var onDismiss: () -> Void
    
    init(image: Binding<Image?>, onDismiss: @escaping () -> Void) {
           _image = image
           self.onDismiss = onDismiss
       }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary // Change to .camera for camera access
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No need for updates
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
            }
            parent.onDismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.onDismiss()
        }
        
        func recognizeText(from image: UIImage) {
            if let cgImage = image.cgImage {
                let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                let request = VNRecognizeTextRequest { request, error in
                    if let error = error {
                        print("Error recognizing text: \(error)")
                        return
                    }
                    guard let observations = request.results as? [VNRecognizedTextObservation] else {
                        return
                    }
                    let recognizedText = observations.compactMap { observation in
                        observation.topCandidates(1).first?.string
                    }.joined(separator: " ")
                    parent.recognizedText = recognizedText
                }
                request.recognitionLevel = .accurate
                do {
                    try handler.perform([request])
                } catch {
                    print("Error performing text recognition: \(error)")
                }
            }}
    }
}
