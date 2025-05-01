//
//  SQHomeNetworkService.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SignQuestModels

// MARK: IMPLEMENT API
struct SQHomeNetworkService {
    func fetchUserData() async -> SQUser {
        let mockUser =  SQUser(
            firstName: "User",
            lastName: "Demo",
            email: "user@example.com",
            age: 25,
            password: "secured"
        )
        return mockUser
    }
    
    func fetchSection() async -> [SQSection] {
        return mockSession()
    }
    
    private func mockSession() -> [SQSection] {
        let alphabetLevels = [
            SQLevel(
                sectionId: "section1",
                number: 1,
                questions: sampleQuestions(),
                minScore: 70,
                status: .completed
            ),
            SQLevel(
                sectionId: "section1",
                number: 2,
                questions: sampleQuestions(),
                minScore: 70,
                status: .available
            ),
            SQLevel(
                sectionId: "section1",
                number: 3,
                questions: sampleQuestions(),
                minScore: 70,
                status: .locked
            ),
            SQLevel(
                sectionId: "section1",
                number: 4,
                questions: sampleQuestions(),
                minScore: 70,
                status: .locked
            ),
            SQLevel(
                sectionId: "section1",
                number: 5,
                questions: sampleQuestions(),
                minScore: 70,
                status: .locked
            )
        ]
        
        // Second section (Basic Signs)
        let basicSignsLevels = [
            SQLevel(
                sectionId: "section2",
                number: 1,
                questions: sampleQuestions(),
                minScore: 60,
                status: .locked
            ),
            SQLevel(
                sectionId: "section2",
                number: 2,
                questions: sampleQuestions(),
                minScore: 60,
                status: .locked
            ),
            SQLevel(
                sectionId: "section2",
                number: 3,
                questions: sampleQuestions(),
                minScore: 60,
                status: .locked
            ),
            SQLevel(
                sectionId: "section2",
                number: 4,
                questions: sampleQuestions(),
                minScore: 60,
                status: .locked
            ),
            SQLevel(
                sectionId: "section2",
                number: 5,
                questions: sampleQuestions(),
                minScore: 60,
                status: .locked
            )
            
        ]
        
        let alphabetSection = SQSection(
            id: "section1",
            number: 1,
            title: "Alphabet",
            description: "Learn the hand gestures for the alphabet",
            levels: alphabetLevels,
            status: .inProgress
        )
        
        let basicSignsSection = SQSection(
            id: "section2",
            number: 2,
            title: "Basic Signs",
            description: "Learn common everyday signs",
            levels: basicSignsLevels,
            status: .locked
        )
        
        let sections = [alphabetSection, basicSignsSection]
        return sections
    }
    
    private func sampleQuestions() -> [SQQuestion] {
        return [
            SQQuestion(
                id: "q1",
                type: .selectAlphabet,
                content: SQQuestionContent(
                    prompt: "hand.raised.fill",
                    isPromptImage: true,
                    answers: [
                        SQAnswer(value: "A", isImage: false),
                        SQAnswer(value: "B", isImage: false),
                        SQAnswer(value: "C", isImage: false),
                        SQAnswer(value: "D", isImage: false)
                    ]
                ),
                correctAnswerIndex: 0
            ),
            SQQuestion(
                id: "q2",
                type: .selectGesture,
                content: SQQuestionContent(
                    prompt: "A",
                    isPromptImage: false,
                    answers: [
                        SQAnswer(value: "hand.raised.fill", isImage: false),
                        SQAnswer(value: "hand.raised.fill", isImage: false),
                        SQAnswer(value: "hand.raised.fill", isImage: false),
                        SQAnswer(value: "hand.raised.fill", isImage: false)
                    ]
                ),
                correctAnswerIndex: 1
            ),
            SQQuestion(
                id: "q3",
                type: .performGesture,
                content: SQQuestionContent(
                    prompt: "A",
                    isPromptImage: false,
                    answers: [
                        SQAnswer(value: "A", isImage: false),
                    ]
                ),
                correctAnswerIndex: 0
            ),
        ]
    }
}

