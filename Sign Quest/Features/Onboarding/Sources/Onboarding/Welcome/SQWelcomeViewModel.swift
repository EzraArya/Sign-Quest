//
//  SQWelcomeViewModel.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import Combine

public class SQWelcomeViewModel: ObservableObject {
    @Published var title: String = "Already have an account?"
    @Published var subtitle: String = "New to SIBI Quest?"
    @Published var buttonTitle: String = "Sign In"
    @Published var buttonSubtitle: String = "Get Started"
    
    public init() {}
}
