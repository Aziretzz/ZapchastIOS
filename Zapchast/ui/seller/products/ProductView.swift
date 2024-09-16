//
//  ProductView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 11/9/24.
//

import SwiftUI

struct ProductView: View {
    @State private var items: [Item] = []
    @State private var page = 1
    @State private var isLoading = false
    @State private var isFetchingMore = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Верхняя панель
                ZStack {
                    Color(hex: "#232A40")
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 80)
                    
                    Text("Мои товары")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                
                ScrollView {
                    LazyVStack {
                        ForEach(items) { item in
                            ItemRow(color: "#232A40", isSeller: true, item: item)
                                .padding()
                        }
                        
                        // Loader for pagination
                        if isLoading {
                            ProgressView()
                                .padding(.vertical, 20)
                        }
                    }
                }
                .onAppear {
                    loadItems()
                }
                .onAppear {
                    loadMoreItemsIfNeeded(currentItem: items.last)
                }
            }
        }
    }
        
        func loadMoreItemsIfNeeded(currentItem: Item?) {
            guard let currentItem = currentItem else { return }
            
            let thresholdIndex = items.index(items.endIndex, offsetBy: -3)
            if items.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
                loadItems()
            }
        }
        
        func loadItems() {
            guard !isLoading else { return }
            isLoading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let newItems = (1...10).map { index in
                    Item(
                        title: "РУЛЬ ЛЕКСУСА GX470 2009Г. НОВЫЙ",
                        description: "Левый руль. Контрактный, без пробега по КП.",
                        category: "РУЛЕВЫЕ ЗАПЧАСТИ",
                        price: "7 000с",
                        image: "img", // Replace with your image
                        views: 21,
                        comments: 12,
                        likes: 456,
                        timeLeft: "4ч.н."
                    )
                }
                self.items.append(contentsOf: newItems)
                self.isLoading = false
            }
        }
    
}

#Preview {
    ProductView()
}
