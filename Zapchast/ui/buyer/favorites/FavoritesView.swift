//
//  FavoritesView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 9/9/24.
//

import SwiftUI

struct FavoritesView: View {
    @State private var items: [Item] = []
    @State private var page = 1
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // Top bar
                ZStack {
                    Color(hex: "#550486")
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 80)
                    
                    
                    Text("Любимые")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                }
                .frame(maxWidth: .infinity)
                
                ScrollView {
                    LazyVStack {
                        ForEach(items) { item in
                            ItemRow(item: item)
                                .padding(.vertical, 10)
                        }
                        
                        // Loader for pagination
                        if isLoading {
                            ProgressView()
                                .padding(.vertical, 20)
                        }
                    }
                    .padding(.horizontal, 16)
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

    // Sample function to load items with pagination
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

    func loadMoreItemsIfNeeded(currentItem: Item?) {
        guard let currentItem = currentItem else { return }
        
        let thresholdIndex = items.index(items.endIndex, offsetBy: -3)
        if items.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            loadItems()
        }
    }
}

#Preview {
    FavoritesView()
}
