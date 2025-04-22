//
//  SQIntroductionViewModel.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI

struct IntroductionPage {
    let title: String
    let boldTitle: String
    let subtitle: String
}

class SQIntroductionViewModel: ObservableObject {
    @Published var pages: [IntroductionPage] = [
        IntroductionPage(title: "Welcome to", boldTitle: "Sign Quest", subtitle: "Your journey into sign language starts here."),
        IntroductionPage(title: "A Place to Learn", boldTitle: "SIBI", subtitle: "Practice signs, complete challenges, and track your progress."),
        IntroductionPage(title: "Ready to", boldTitle: "Start?", subtitle: "Create your account and begin your quest today.")
    ]
}
