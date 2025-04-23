//
//  SQRegisterView.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQRegisterView: View {
    @State private var currentTab = 0
    @State private var age = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) private var dismiss
    
    @State private var agePageValid = false
    @State private var namePageValid = false
    @State private var emailPageValid = false
    @State private var passwordPageValid = false
    @State private var navigateToGreeting = false
    
    @State private var progressAmount = 25.0
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    if currentTab == 0 {
                        dismiss()
                    } else {
                        currentTab -= 1
                        progressAmount -= 25
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(SQColor.secondary.color)
                }
                
                Spacer()
                
                SQProgressBar(progress: $progressAmount)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 8)
            
            VStack(alignment: .leading) {
                TabView(selection: $currentTab) {
                    SQRegistrationAgePage(
                        age: $age,
                        isValid: $agePageValid
                    )
                    .tag(0)
                    SQRegistrationNamePage(
                        firstName: $firstName,
                        lastName: $lastName,
                        isValid: $namePageValid
                    )
                    .tag(1)
                    SQRegistrationEmailPage(
                        email: $email,
                        isValid: $emailPageValid
                    )
                    .tag(2)
                    SQRegistrationPasswordPage(
                        password: $password,
                        confirmPassword: $confirmPassword,
                        isValid: $passwordPageValid
                    )
                    .tag(3)
                }
                .tabViewStyle(
                    PageTabViewStyle(
                        indexDisplayMode: .never
                    )
                )
                .padding(.top, 16)
                
                Spacer()
                
                SQButton(text: currentTab < 3 ? "Continue" : "Create Profile", font: .bold, style: .default, size: 16) {
                    switch currentTab {
                    case 0:
                        if agePageValid {
                            currentTab += 1
                            progressAmount += 25
                        }
                    case 1:
                        if namePageValid {
                            currentTab += 1
                            progressAmount += 25
                        }
                    case 2:
                        if emailPageValid {
                            currentTab += 1
                            progressAmount += 25
                        }
                    case 3:
                        if passwordPageValid {
                            navigateToGreeting.toggle()
                        }
                    default:
                        break
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .applyBackground()
        .toolbar(.hidden)
        .navigationDestination(isPresented: $navigateToGreeting) {
            SQGreetView()
        }
    }
}
