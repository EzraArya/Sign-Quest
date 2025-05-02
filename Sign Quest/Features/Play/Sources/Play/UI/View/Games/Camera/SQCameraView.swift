//
//  SQCameraView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 30/04/25.
//

import Foundation
import SwiftUI
import UIKit
import SignQuestUI

struct SQCameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @EnvironmentObject var coordinator: SQPlayCoordinator
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No Updates Needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: SQCameraView
        
        init(_ parent: SQCameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            
            parent.coordinator.dismissSheet()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.coordinator.dismissSheet()
        }
    }
}
