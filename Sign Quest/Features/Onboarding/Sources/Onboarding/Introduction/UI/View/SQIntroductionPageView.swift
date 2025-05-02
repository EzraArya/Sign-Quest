//
//  SQIntroductionPageView.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQIntroductionPageView: View {
    var title: String
    var boldTitle: String
    var subtitle: String
    
    public init(title: String, boldTitle: String, subtitle: String) {
        self.title = title
        self.boldTitle = boldTitle
        self.subtitle = subtitle
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            HStack {
                SQText(text: title, font: .bold, color: .text, size: 28)
                SQText(text: boldTitle, font: .bold, color: .primary, size: 28)
            }
            SQText(text: subtitle, font: .regular, color: .placeholder, size: 16)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
}
