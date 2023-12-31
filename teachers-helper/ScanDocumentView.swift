//
//  ScanDocumentView.swift
//  teachers-helper
//
//  Created by Richard Menning on 21.08.23.
//

import SwiftUI
import VisionKit
struct ScanDocumentView: UIViewControllerRepresentable {
  
    @Binding var recognizedText: String
        
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, parent: self)
    }
    
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
           let documentViewController = VNDocumentCameraViewController()
           documentViewController.delegate = context.coordinator
           return documentViewController
       }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
                // nothing to do here
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
      
        var recognizedText: Binding<String>
        var parent: ScanDocumentView
        
        init(recognizedText: Binding<String>, parent: ScanDocumentView) {
            self.recognizedText = recognizedText
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            // do the processing of the scan
        }
    }
    
}
