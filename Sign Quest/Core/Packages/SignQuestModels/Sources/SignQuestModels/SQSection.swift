//
//  SQSection.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation
import FirebaseFirestore

public struct SQSection: Codable, Identifiable, Hashable, @unchecked Sendable {
    @DocumentID
    public var id: String?
    
    public let number: Int
    public let title: String
    public let description: String
    
    public var displayName: String {
        return "Section \(number)"
    }
}
