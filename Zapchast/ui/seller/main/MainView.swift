//
//  MainView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 11/9/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = OnBoardViewModel()
    @State private var selectedTab: Int = 0
    @State var selectedName: String = "Заказы"
    
    var body: some View {
            VStack {
                

                
                // Контент на основе выбранной вкладки
                Spacer()
                
                switch selectedTab {
                case 0:
                    OrdersView()
                case 1:
                    ProductView()
                case 2:
                    AddProductView()
                case 3:
                    ChatView(color: "#232A40")
                case 4:
                    ProfileView(color: "#232A40").environmentObject(viewModel)
                default:
                    Text("Home View")
                }
                
                Spacer()
                
                ZStack {
                    // Фон с закругленными углами
                    Color(hex: "#232A40")
                        .clipShape(Capsule())
                        .frame(height: 60)
                        .padding(.horizontal, 20) // Добавляем отступы для округления
                    
                    HStack(spacing: 40) {
                        // Иконки вкладок
                        Button(action: {
                            selectedTab = 0
                            selectedName = "Заказы"
                        }) {
                            Image(systemName: "list.bullet.rectangle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 0 ? .blue : .white)
                        }
                        
                        Button(action: {
                            selectedTab = 1
                            selectedName = "Мои товары"
                        }) {
                            Image(systemName: "archivebox.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 1 ? .blue : .white)
                        }
                        
                        Button(action: {
                            selectedTab = 2
                            selectedName = "Добавить товар"
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 2 ? .blue : .white)
                        }
                        
                        Button(action: {
                            selectedTab = 3
                            selectedName = "Чаты"
                        }) {
                            Image(systemName: "bubble.left.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 3 ? .blue : .white)
                        }
                        
                        Button(action: {
                            selectedTab = 4
                            selectedName = "Профиль"
                        }) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == 4 ? .blue : .white)
                        }
                    }
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .padding(.top, -60)
        }
    
}
#Preview {
    MainView()
}
