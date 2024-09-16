//
//  OrdersView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 11/9/24.
//

import SwiftUI

struct OrdersView: View {
    @State private var selectedTab = 0
    @State private var activeItems = AuctionItem.sampleActiveItems
    @State private var completedItems = AuctionItem.sampleCompletedItems
    @State private var isFetchingMore = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Верхняя панель
                ZStack {
                    Color(hex: "#232A40")
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 80)
                    
                    Text("Заказы")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                
                
                // Segmented control for switching tabs
                Picker(selection: $selectedTab, label: Text("")) {
                    Text("Действующие").tag(0)
                    Text("Завершенные").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Content based on selected tab
                ScrollView {
                    LazyVStack {
                        if selectedTab == 0 {
                            // Active auctions
                            ForEach(activeItems) { item in
                                AuctionItemView(item: item)
                                    .onAppear {
                                        if item == activeItems.last {
                                            loadMoreItems(for: "active")
                                        }
                                    }
                            }
                        } else {
                            // Completed auctions
                            ForEach(completedItems) { item in
                                AuctionItemView(item: item)
                                    .onAppear {
                                        if item == completedItems.last {
                                            loadMoreItems(for: "completed")
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func loadMoreItems(for type: String) {
        guard !isFetchingMore else { return }
        isFetchingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if type == "active" {
                let newItems = AuctionItem.sampleActiveItems // Replace with your actual data fetching
                activeItems.append(contentsOf: newItems)
            } else {
                let newItems = AuctionItem.sampleCompletedItems // Replace with your actual data fetching
                completedItems.append(contentsOf: newItems)
            }
            isFetchingMore = false
        }
    }
}

// Model and sample data
struct AuctionItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let category: String
    let description: String
    let price: String
    let imageName: String
    
    // Явная реализация Equatable
    static func == (lhs: AuctionItem, rhs: AuctionItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let sampleActiveItems = [
        AuctionItem(title: "Руль Лексуса GX470 2009г. Новый", category: "Рулевые запчасти", description: "Левый руль. Контрактный, без пробега по КР. Lexus GX470...", price: "7 000с", imageName: "onboard1"),
        AuctionItem(title: "Ароматизатор для авто", category: "Аксессуары", description: "Деревянный ароматизатор для авто с запахом ванили", price: "500с", imageName: "air_freshener")
    ]
    
    static let sampleCompletedItems = [
        AuctionItem(title: "Завершенная продажа 1", category: "Завершенные", description: "Описание завершенного товара 1", price: "0с", imageName: "completed_1"),
        AuctionItem(title: "Завершенная продажа 2", category: "Завершенные", description: "Описание завершенного товара 2", price: "0с", imageName: "completed_2")
    ]
}

// Auction item view
struct AuctionItemView: View {
    var item: AuctionItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
            
            Text(item.title)
                .font(.headline)
                .padding(.top, 5)
            
            Text("Категория: \(item.category)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(item.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
            
            Text(item.price)
                .font(.headline)
                .padding(.top, 5)
            
            Divider()
                .padding(.top, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}


#Preview {
    OrdersView()
}
