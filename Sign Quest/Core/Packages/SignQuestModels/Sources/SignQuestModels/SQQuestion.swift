//
//  SQQuestion.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import FirebaseFirestore

public enum SQQuestionType: String, Codable, Sendable {
    case selectAlphabet
    case selectGesture
    case performGesture
}

public struct SQQuestion: Codable, Identifiable, Hashable, @unchecked Sendable {
    @DocumentID public var id: String?
    public let levelId: String
    public let type: SQQuestionType
    public let content: SQQuestionContent
    public let correctAnswerIndex: Int
    
    public var correctAnswer: SQAnswer {
        return content.answers[correctAnswerIndex]
    }
    
    public init(id: String, levelId: String, type: SQQuestionType, content: SQQuestionContent, correctAnswerIndex: Int) {
        self.id = id
        self.levelId = levelId
        self.type = type
        self.content = content
        self.correctAnswerIndex = correctAnswerIndex
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: SQQuestion, rhs: SQQuestion) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct SQQuestionContent: Codable, Hashable, Sendable {
    public let prompt: String
    public let isPromptImage: Bool
    public let answers: [SQAnswer]
    public let exampleImage: String?
    
    public init(prompt: String, isPromptImage: Bool, answers: [SQAnswer], exampleImage: String? = nil) {
        self.prompt = prompt
        self.isPromptImage = isPromptImage
        self.answers = answers
        self.exampleImage = exampleImage
    }
}

public struct SQAnswer: Codable, Hashable, Sendable {
    public let value: String
    public let isImage: Bool
    
    public init(value: String, isImage: Bool) {
        self.value = value
        self.isImage = isImage
    }
}
