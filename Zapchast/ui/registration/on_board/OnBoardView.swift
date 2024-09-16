//
//  OnBoardView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 8/9/24.
//

import SwiftUI

struct OnBoardView: View {
    @EnvironmentObject var onBoardViewModel: OnBoardViewModel
    
    @State private var currentStep = 0 // Track the current step
    let totalSteps = 3 // Total number of onboarding screens
    var isShow = false
    var isSeller = true
    var body: some View {
        NavigationView {
            if onBoardViewModel.isShow() ?? false {
                if onBoardViewModel.isSeller() ?? false {
                    MainView().environmentObject(onBoardViewModel)
                } else {
                    HomeView().environmentObject(onBoardViewModel)
                }
            } else {
                VStack(spacing: 0) {
                    
                    // Top bar with background color matching text color
                    ZStack {
                        Color.orange // Цвет, такой же как у текста заголовка
                            .ignoresSafeArea(edges: .top)
                            .frame(height: 120)
                        
                        Text(welcomeTexts[currentStep])
                            .font(.custom("ArabicFontName", size: 24)) // Replace with actual font if needed
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity) // Растягиваем по горизонтали
                    
                    
                    Spacer()
                    
                    // Image that changes based on current step
                    Image(onboardingImages[currentStep])
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .transition(.scale) // Apply scale transition for smooth animation
                    
                    Spacer()
                    
                    // Russian welcome text that changes based on current step
                    Text(russianTexts[currentStep])
                        .font(.system(size: 18, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .transition(.slide) // Apply slide transition for smooth animation
                    
                    Spacer()
                    
                    // Navigation controls
                    HStack {
                        // Skip button
                        Button(action: {
                            // Skip action to move directly to the last screen
                            withAnimation {
                                currentStep = totalSteps - 1
                            }
                        }) {
                            Text("Skip")
                                .font(.system(size: 16))
                                .foregroundColor(.orange)
                        }
                        
                        Spacer()
                        
                        // Pagination dots
                        HStack(spacing: 8) {
                            ForEach(0..<totalSteps, id: \.self) { index in
                                Circle()
                                    .fill(index == currentStep ? Color.orange : Color.gray.opacity(0.5))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        
                        Spacer()
                        
                        // Next button with conditional navigation
                        if currentStep < totalSteps - 1 {
                            Button(action: {
                                withAnimation {
                                    if currentStep < totalSteps - 1 {
                                        currentStep += 1 // Move to the next screen
                                    }
                                }
                            }) {
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.orange)
                                    .clipShape(Circle())
                            }
                        } else {
                            // When at the last step, navigate to the next screen
                            NavigationLink(destination: RoleSelectionView()) {
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.orange)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                }
                .background(Color.white.edgesIgnoringSafeArea(.all))
                .animation(.easeInOut(duration: 0.5), value: currentStep) // Animation for the entire view
            }
        }
    }
}

// Data for onboarding screens (texts and images)
let welcomeTexts = [
    "ЗДРАВСТВУЙТЕ",
    "ЦЕЛЬ ПРИЛОЖЕНИЯ",
    "УДАЧИ В ПРИЛОЖЕНИИ"
]

let onboardingImages = [
    "onboard1", // Replace with your image names
    "onboard2",
    "onboard3"
]

let russianTexts = [
    "Мы рады приветствовать вас в своем приложении. Хотите узнать наши цели?",
    "Наша цель облегчить для вас поиск запчастей, и их продажу",
    "Легких покупок и быстрых продаж!"
]

#Preview {
    OnBoardView()
}
