//
//  HomeView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 9/9/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    @State private var selectedName: String = "Рекомендации"
    
    var body: some View {
  
            VStack {
            
                
                // Content based on the selected tab
                Spacer()
                
                switch selectedTab {
                case 0:
                    RecommendView()
                case 1:
                    SearchView()
                case 2:
                    FavoritesView()
                case 3:
                    ChatView(color: "#550486")
                case 4:
                    ProfileView(color: "#550486")
                default:
                    Text("Home View")
                }
                
                Spacer()
                
                ZStack {
                    // Background with rounded corners
                    Color(hex: "#550486")
                        .clipShape(Capsule())
                        .frame(height: 60)
                        .padding(.horizontal, 20) // Add horizontal padding for the rounded effect
                    
                    HStack(spacing: 40) {
                        // Tab icons
                        Button(action: {
                            selectedTab = 0
                            selectedName = "Рекомендации"
                        }) {
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 0 ? .black : .white)
                        }
                        
                        Button(action: {
                            selectedTab = 1
                            selectedName = "Поиск"
                        }) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 1 ? .black : .white)
                        }
                        
                        Button(action: {
                            selectedTab = 2
                            selectedName = "Любимые"
                        }) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 2 ? .black : .white)
                        }
                        
                        Button(action: {
                            selectedTab = 3
                            selectedName = "Чат"
                        }) {
                            Image(systemName: "message.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 3 ? .black : .white)
                        }
                        
                        Button(action: {
                            selectedTab = 4
                            selectedName = "Профиль"
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 4 ? .black : .white)
                        }
                    }
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .padding(.top, -60)
        }
    
}

#Preview {
    HomeView()
}
