//
//  SQBanner.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI

public struct SQBanner: View {
    public var section: String
    public var title: String
    
    public init(section: String, title: String) {
        self.section = section
        self.title = title
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            SQText(text: section, font: .medium, color: .text, size: 14)
            SQText(text: title, font: .bold, color: .text, size: 18)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
        .background(SQColor.primary.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
