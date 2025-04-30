//
//  SQGamesTypeThreePageViewModel.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 30/04/25.
//

import Foundation
import SwiftUI
import YOLO

class SQGamesTypeThreeViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var yoloResult: YOLOResult?
    
    private let yolo = YOLO("yolo", task: .detect)
    @Published var modelFound: Bool = false
    private var modelPath: String = ""
    
    init() {
        setupModel()
    }
    
    func processImageWithYolo(_ image: UIImage) {
        yoloResult = yolo(image)
    }
    
    func getCorrectOrientationUIImage(uiImage: UIImage) -> UIImage {
        var newImage = UIImage()
        let ciContext = CIContext()
        switch uiImage.imageOrientation.rawValue {
        case 1:
            guard let orientedCIImage = CIImage(image: uiImage)?.oriented(CGImagePropertyOrientation.down),
                  let cgImage = ciContext.createCGImage(orientedCIImage, from: orientedCIImage.extent)
            else { return uiImage }
            
            newImage = UIImage(cgImage: cgImage)
        case 3:
            guard let orientedCIImage = CIImage(image: uiImage)?.oriented(CGImagePropertyOrientation.right),
                  let cgImage = ciContext.createCGImage(orientedCIImage, from: orientedCIImage.extent)
            else { return uiImage }
            newImage = UIImage(cgImage: cgImage)
        default:
            newImage = uiImage
        }
        return newImage
    }
    
    func setButtonText() -> String {
        if selectedImage != nil {
            return "Retake Photo"
        } else {
            return "Open Camera"
        }
    }
    
    func getTopDetection() -> (label: String, confidence: Int)? {
        if let topBox = yoloResult?.boxes.max(by: { $0.conf < $1.conf }) {
            return (topBox.cls, Int(topBox.conf * 100))
        }
        return nil
    }
    
    private func setupModel() {
        if let modelURL = Bundle.main.url(forResource: "yolo", withExtension: "mlmodel") {
            print("✅ Found original model at: \(modelURL)")
            modelPath = modelURL.path
            modelFound = true
        }
        // Then try the compiled model directory
        else if let modelURL = Bundle.main.url(forResource: "yolo", withExtension: "mlmodelc") {
            print("✅ Found compiled model at: \(modelURL)")
            modelPath = modelURL.path
            modelFound = true
        }
        // If still not found, debug bundle contents
        else {
            print("❌ Model not found in expected locations")
            
            // Debug what's actually in the bundle
            if let resourcePath = Bundle.main.resourcePath {
                do {
                    let items = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                    print("Bundle contents: \(items)")
                    
                    // Look for any ML-related files
                    let mlFiles = items.filter { $0.contains(".ml") }
                    print("ML files found: \(mlFiles)")
                } catch {
                    print("Error listing directory: \(error)")
                }
            }
        }
    }
}
