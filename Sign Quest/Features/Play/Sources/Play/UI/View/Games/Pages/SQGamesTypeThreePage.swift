//
//  SQGamesTypeThreePage.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI
import YOLO
import PhotosUI

public struct SQGamesTypeThreePage: View {
    @StateObject private var viewModel = SQGamesTypeThreeViewModel()
    @EnvironmentObject var coordinator: SQPlayCoordinator
    @Binding private var parentSelectedImage: UIImage?
    
    public init(selectedImage: Binding<UIImage?>) {
        self._parentSelectedImage = selectedImage
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SQText(text: "Perform this", font: .bold, color: .text, size: 24)
                SQText(text: "Gesture", font: .bold, color: .primary, size: 24)
            }
            Spacer()
            
            HStack{
                Spacer()
                VStack(alignment: .center, spacing: 36){
                    SQText(text: "A", font: .bold, color: .text, size: 64)
                    
                    if let image = viewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 312, height: 312)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(SQColor.primary.color, lineWidth: 2)
                            )
                        
                        if let (label, confidence) = viewModel.getTopDetection() {
                            HStack {
                                Text(label)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(SQColor.text.color)
                                
                                Spacer()
                                
                                Text("\(confidence)%")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(SQColor.primary.color)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(SQColor.textbox.color)
                            .cornerRadius(8)
                            .padding(.top, 12)
                        }
                    } else {
                        Text("Select an image")
                            .foregroundStyle(SQColor.accent.color)
                            .frame(width: 312, height: 312)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(SQColor.primary.color, lineWidth: 2)
                            )
                    }
                }
                Spacer()
            }
            
            Spacer()
            SQButton(text: viewModel.setButtonText(), font: .bold, style: .secondary, size: 16) {
                coordinator.presentSheet(.camera($viewModel.selectedImage))
            }
            .padding(.bottom, 12)
        }
        .applyBackground()
        .toolbar(.hidden, for: .tabBar)
        .onChange(of: viewModel.selectedImage) { oldImage, newImage in
            if let image = newImage {
                let correctedImage = viewModel.getCorrectOrientationUIImage(uiImage: image)
                viewModel.processImageWithYolo(correctedImage)
                parentSelectedImage = image  // sync with parent
            } else {
                viewModel.yoloResult = nil
                parentSelectedImage = nil  // sync with parent
            }
        }
        .onChange(of: parentSelectedImage) { _, newImage in
            viewModel.selectedImage = newImage
        }
        .onAppear {
            viewModel.selectedImage = parentSelectedImage
        }
    }
}
