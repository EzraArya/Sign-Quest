//
//  SQGamesTypeThreePage.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI
import YOLO

public struct SQGamesTypeThreePage: View {
    @State private var modelPath: String = ""
    @State private var modelFound: Bool = false
    
    public init() {
        setupModel()
    }
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SQText(text: "Perform this", font: .bold, color: .text, size: 24)
                SQText(text: "Gesture", font: .bold, color: .primary, size: 24)
            }
            Spacer()
            
            VStack(spacing: 36){
                SQText(text: "A", font: .bold, color: .text, size: 64)
                
                if modelFound {
                    YOLOCamera(
                        modelPathOrName: "yolo",
                        task: .detect,
                        cameraPosition: .front
                    )
                    .frame(width: 312, height: 312)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(SQColor.primary.color, lineWidth: 2)
                    )
                } else {
                    Text("Model not found in main bundle")
                        .frame(width: 312, height: 312)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            
            Spacer()
            Spacer()
        }
        .applyBackground()
        .toolbar(.hidden, for: .tabBar)
    }
    
    private mutating func setupModel() {
        if let modelURL = Bundle.main.url(forResource: "yolo", withExtension: "mlmodel") {
            print("✅ Found original model at: \(modelURL)")
            _modelPath = State(initialValue: modelURL.path)
            _modelFound = State(initialValue: true)
        }
        // Then try the compiled model directory
        else if let modelURL = Bundle.main.url(forResource: "yolo", withExtension: "mlmodelc") {
            print("✅ Found compiled model at: \(modelURL)")
            _modelPath = State(initialValue: modelURL.path)
            _modelFound = State(initialValue: true)
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
