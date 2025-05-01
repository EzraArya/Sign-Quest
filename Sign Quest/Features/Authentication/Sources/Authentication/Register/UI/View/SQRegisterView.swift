//
//  SQRegisterView.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQRegisterView: View {
    @EnvironmentObject var coordinator: SQAuthenticationCoordinator
    @StateObject private var viewModel = SQRegisterViewModel()

    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    if viewModel.currentTab == 0 {
                        viewModel.navigateToOnboarding()
                    } else {
                        viewModel.decrementProgress()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(SQColor.secondary.color)
                }
                
                Spacer()
                
                SQProgressBar(progress: $viewModel.progressAmount)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 8)
            
            VStack(alignment: .leading) {
                TabView(selection: $viewModel.currentTab) {
                    SQRegistrationAgePage(
                        age: $viewModel.age,
                        isValid: $viewModel.agePageValid
                    )
                    .tag(0)
                    SQRegistrationNamePage(
                        firstName: $viewModel.firstName,
                        lastName: $viewModel.lastName,
                        isValid: $viewModel.namePageValid
                    )
                    .tag(1)
                    SQRegistrationEmailPage(
                        email: $viewModel.email,
                        isValid: $viewModel.emailPageValid
                    )
                    .tag(2)
                    SQRegistrationPasswordPage(
                        password: $viewModel.password,
                        confirmPassword: $viewModel.confirmPassword,
                        isValid: $viewModel.passwordPageValid
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
                
                SQButton(text: viewModel.currentTab < 3 ? "Continue" : "Create Profile", font: .bold, style: .default, size: 16) {
                    switch viewModel.currentTab {
                    case 0:
                        if viewModel.agePageValid {
                            viewModel.incrementProgress()
                        }
                    case 1:
                        if viewModel.namePageValid {
                            viewModel.incrementProgress()
                        }
                    case 2:
                        if viewModel.emailPageValid {
                            viewModel.incrementProgress()
                        }
                    case 3:
                        if viewModel.passwordPageValid {
                            viewModel.createAccount()
                        }
                    default:
                        break
                    }
                }
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
        .applyBackground()
        .toolbar(.hidden)
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}
