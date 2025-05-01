//
//  SQLeaderboardViewModel.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 02/05/25.
//

import SwiftUI
import Combine
import SignQuestModels

class SQLeaderboardViewModel: ObservableObject {
    @Published var leaderboardData: [SQUser] = []
    private var networkService: SQLeaderboardNetworkService = SQLeaderboardNetworkService()
    
    init() {}
    
    @MainActor
    func fetchLeaderboardData() async {
        let data = await networkService.fetchLeaderboardData()
        self.leaderboardData = data.sorted { (user1: SQUser, user2: SQUser) -> Bool in
            return user1.totalScore > user2.totalScore
        }
    }
}
