//
//  SQLeaderboardViewModel.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 02/05/25.
//

import SwiftUI
import Combine
import SignQuestModels

@MainActor
class SQLeaderboardViewModel: ObservableObject {
    @Published var leaderboardData: [SQUser] = []
    @Published var isLoading: Bool = true
    
    private var networkService: SQLeaderboardNetworkServiceProtocol
    
    init(networkService: SQLeaderboardNetworkServiceProtocol = SQLeaderboardNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchLeaderboardData() async {
        isLoading = true
        do {
            let data = try await networkService.fetchLeaderboardData()
            
            await MainActor.run {
                self.leaderboardData = data
                self.isLoading = false
            }
        } catch {
            print("❌ Error fetching leaderboard data: \(error.localizedDescription)")
            await MainActor.run {
                self.leaderboardData = []
                self.isLoading = false
            }
        }
    }
}
