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
    
    @State private var recognizedText = "Tap button to start scanning"
    @State private var actionType: ActionType? = nil
    @State private var selectedImage: UIImage?
    
    enum ActionType {
         case camera
         case library
     }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.gray.opacity(0.2))
                        
                        Text(recognizedText).padding()
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        HStack {
                            
                            Button(action: {
                                self.showingScanningView = true
                            }) {
                                Text("Start Scanning")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Capsule().fill(Color.blue))
                            
                            Spacer()
                            
                            Button(action: {
                                self.showingLibraryView = true
                            }) {
                                Text("Choose from library")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Capsule().fill(Color.blue))
                        }
                        
                    }
                    .padding()
                }
                .navigationBarTitle("Text Recognition")
                .sheet(item: $actionType) {
                               ScanDocumentView(recognizedText: self.$recognizedText)
                           }
            }
        }
    }
}
