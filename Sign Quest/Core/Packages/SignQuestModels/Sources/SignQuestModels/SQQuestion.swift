//
//  SQQuestion.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

enum SQQuestionType: String, Codable {
    case selectAlphabet
    case selectGesture
    case performGesture
}

struct SQQuestion: Codable, Identifiable, Hashable {
    let id: String
    let type: SQQuestionType
    let content: SQQuestionContent
    let correctAnswerIndex: Int
    
    var correctAnswer: SQAnswer {
        return content.answers[correctAnswerIndex]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SQQuestion, rhs: SQQuestion) -> Bool {
        return lhs.id == rhs.id
    }
}

struct SQQuestionContent: Codable, Hashable {
    let prompt: String
    let isPromptImage: Bool
    let answers: [SQAnswer]
    let exampleImage: String?
}

struct SQAnswer: Codable, Hashable {
    let value: String
    let isImage: Bool
}
