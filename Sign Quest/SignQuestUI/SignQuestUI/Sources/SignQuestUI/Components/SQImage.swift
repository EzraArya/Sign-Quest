//
//  SQImage.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI

public struct SQImage: View {
    public var image: String
    public var width: CGFloat?
    public var height: CGFloat?
    public var color: SQColor
    
    public init(image: String, width: CGFloat? = 24, height: CGFloat? = 24, color: SQColor = .accent) {
        self.image = image
        self.width = width
        self.height = height
        self.color = color
    }
    
    public var body: some View {
        Image(systemName: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .foregroundColor(color.color)
    }

}
