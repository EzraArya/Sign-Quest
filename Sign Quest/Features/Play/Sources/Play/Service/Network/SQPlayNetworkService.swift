//
//  SQPlayNetworkService.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 04/05/25.
//

import SignQuestModels
import Foundation

struct SQPlayNetworkService {
    func fetchLevel(levelId: String) async -> SQLevel {
        return SQLevel(
            id: levelId,
            sectionId: "sample-section-id",
            number: 1,
            questions: createSampleQuestions(),
            minScore: 70,
            status: .available
        )
    }
}

extension SQPlayNetworkService {
    private func createSampleQuestions() -> [SQQuestion] {
        return [
            addAlphabetQuestion(prompt: "hand.raised", correctIndex: 0),
            addGestureQuestion(prompt: "A", correctIndex: 1),
            addPerformQuestion(prompt: "A", alphabet: "A"),
            addGestureQuestion(prompt: "B", correctIndex: 0),
            addPerformQuestion(prompt: "C", alphabet: "C"),
            addGestureQuestion(prompt: "C", correctIndex: 1),
            addPerformQuestion(prompt: "Y", alphabet: "Y"),
        ]
    }

    
    private func addAlphabetQuestion(prompt: String, correctIndex: Int) -> SQQuestion{
        return SQQuestion(
            id: UUID().uuidString,
            type: .selectAlphabet,
            content: SQQuestionContent(
                prompt: prompt,
                isPromptImage: true,
                answers: [
                    SQAnswer(value: "A", isImage: false),
                    SQAnswer(value: "B", isImage: false),
                    SQAnswer(value: "C", isImage: false),
                    SQAnswer(value: "D", isImage: false)
                ]
            ),
            correctAnswerIndex: correctIndex
        )
    }
    
    private func addGestureQuestion(prompt: String, correctIndex: Int) -> SQQuestion{
        return SQQuestion(
            id: UUID().uuidString,
            type: .selectGesture,
            content: SQQuestionContent(
                prompt: prompt,
                isPromptImage: false,
                answers: [
                    SQAnswer(value: "hand.raised", isImage: true),
                    SQAnswer(value: "hand.point.left", isImage: true),
                    SQAnswer(value: "hand.draw", isImage: true),
                    SQAnswer(value: "hand.wave", isImage: true)
                ]
            ),
            correctAnswerIndex: correctIndex
        )
    }
    
    private func addPerformQuestion(prompt: String, alphabet: String) -> SQQuestion{
        return SQQuestion(
            id: UUID().uuidString,
            type: .performGesture,
            content: SQQuestionContent(
                prompt: prompt,
                isPromptImage: false,
                answers: [
                    SQAnswer(value: alphabet, isImage: false)
                ]
            ),
            correctAnswerIndex: 0
        )
    }
}
