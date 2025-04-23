//
//  SQSeperator.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI

public struct SQSeperator: View {
    public var color: SQColor
    
    public init(color: SQColor) {
        self.color = color
    }
    
    public var body: some View {
        Rectangle()
            .fill(color.color)
            .frame(height: 2)
            .frame(maxWidth: .infinity)
    }
}
            
