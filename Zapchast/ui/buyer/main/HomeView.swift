//
//  HomeView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 9/9/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            // Your content based on the selected tab
            Spacer()
            
            switch selectedTab {
            case 0:
                Text("Home View")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
            case 1:
                Text("Search View")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
            case 2:
                Text("Favorites View")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
            case 3:
                Text("Messages View")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
            case 4:
                Text("Profile View")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
            default:
                Text("Home View")
            }
            
            Spacer()
            
            ZStack {
                // Background with rounded corners
                Color.purple
                    .clipShape(Capsule())
                    .frame(height: 60)
                    .padding(.horizontal, 20) // Add horizontal padding for the rounded effect
                
                HStack(spacing: 40) {
                    // Tab icons
                    Button(action: {
                        selectedTab = 0
                    }) {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedTab == 0 ? .black : .white)
                    }
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedTab == 1 ? .black : .white)
                    }
                    
                    Button(action: {
                        selectedTab = 2
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedTab == 2 ? .black : .white)
                    }
                    
                    Button(action: {
                        selectedTab = 3
                    }) {
                        Image(systemName: "message.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedTab == 3 ? .black : .white)
                    }
                    
                    Button(action: {
                        selectedTab = 4
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedTab == 4 ? .black : .white)
                    }
                }
            }
            .padding(.bottom, 20) // Adds padding at the bottom of the screen
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    HomeView()
}
