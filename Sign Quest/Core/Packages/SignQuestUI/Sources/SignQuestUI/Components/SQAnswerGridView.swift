//
//  SQAnswerGrid.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//
import SwiftUI

public struct SQAnswerGridView: View {
    @State private var selectedAnswerIndex: Int? = nil
    let answerOptions: [String]
    var onAnswerSelected: (Int) -> Void
    let isImage: Bool
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public init(answerOptions: [String], onAnswerSelected: @escaping (Int) -> Void, isImage: Bool = false) {
        self.answerOptions = answerOptions
        self.onAnswerSelected = onAnswerSelected
        self.isImage = isImage
    }
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(0..<min(4, answerOptions.count), id: \.self) { index in
                SQAnswerCell(
                    text: answerOptions[index],
                    isSelected: selectedAnswerIndex == index,
                    isImage: isImage
                )
                .padding(.horizontal, 8)
                .onTapGesture {
                    selectedAnswerIndex = index
                    onAnswerSelected(index)
                }
            }
        }
        .padding()
    }
}

struct SQAnswerCell: View {
    let text: String
    let isSelected: Bool
    let isImage: Bool
    
    var body: some View {
        VStack {
            if isImage {
                SQImage(
                    image: text,
                    width: 32,
                    height: 32,
                    color: .cream)
            } else {
                SQText(
                    text: text,
                    font: .bold,
                    color: isSelected ? .primary : .placeholder,
                    size: 24
                )
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 64)
        .background(isSelected ? SQColor.secondary.color : SQColor.background.color)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(SQColor.primary.color, lineWidth: 2)
        )
        .shadow(radius: isSelected ? 5 : 0)
    }
}
