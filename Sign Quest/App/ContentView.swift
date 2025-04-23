//
//  ContentView.swift
//  Sign Quest
//
//  Created by Ezra Arya Wijaya on 21/04/25.
//

import SwiftUI
import SignQuestUI
import Onboarding
import Dashboard

struct ContentView: View {
    @State private var isLoggedIn: Bool = true
    
    var body: some View {
        if isLoggedIn {
            SQDashboardView()
        } else {
            SQWelcomeView()
        }
    }
}

