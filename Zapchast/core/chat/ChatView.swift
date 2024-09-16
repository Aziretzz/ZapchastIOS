//
//  ChatView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 11/9/24.
//

import SwiftUI

struct ChatView: View {
    var color: String = "#222222"
    @State private var searchText = ""
    @State private var chats = Chat.sampleChats
    @State private var isFetchingMore = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Верхняя панель
                ZStack {
                    Color(hex: color)
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 80)
                    
                    Text("Чаты")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                
                // Search and Filter Buttons
                HStack {
                    SearchBar(color: color)
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Chat List with Pagination
                ScrollView {
                    LazyVStack {
                        ForEach(chats.filter({ searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText) })) { chat in
                            ChatRowView(chat: chat)
                                .onAppear {
                                    if chat == chats.last {
                                        loadMoreChats()
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
    
    private func loadMoreChats() {
        guard !isFetchingMore else { return }
        isFetchingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newChats = Chat.sampleChats // Replace with actual pagination data fetching
            chats.append(contentsOf: newChats)
            isFetchingMore = false
        }
    }
}

struct SearchBar: View {
    let color: String
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                
                TextField("Search", text: $searchText)
                    .padding(7)
                    .background(Color.white)
            }
            .padding(.leading, 10)
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            Button(action: {
                // Действие для кнопки фильтра
            }) {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: color)) // Цвет фона
                    .cornerRadius(16) // Скругленные углы
            }
            .frame(width: 56, height: 56) // Размер кнопки
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Тень
        }
    }
}


// Model and sample data for preview
struct Chat: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let time: String
    let imageName: String
    
    static let sampleChats = [
        Chat(name: "krash nomer 1", lastMessage: "Менин товарым кана?", time: "1:47", imageName: "onboard1"),
        Chat(name: "KAAAAAK", lastMessage: "просмотрено час назад", time: "12:03", imageName: "avatar2"),
        Chat(name: "Asadullo", lastMessage: "отдши руль тема тушуту!", time: "11:37", imageName: "avatar3"),
        Chat(name: "Gogusch", lastMessage: "товарына беш с...", time: "07:59", imageName: "avatar4"),
        Chat(name: "+996704567890", lastMessage: "Торг барбы жетипи?", time: "12:35", imageName: "avatar5"),
        Chat(name: "Jamshut", lastMessage: "просмотрено два часа назад", time: "вчера", imageName: "avatar6")
    ]
}

#Preview {
    ChatView()
}
