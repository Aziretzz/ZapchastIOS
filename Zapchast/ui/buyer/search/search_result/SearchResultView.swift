//
//  SearchResultView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 9/9/24.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let price: String
    let image: String
    let views: Int
    let comments: Int
    let likes: Int
    let timeLeft: String
}

struct SearchResultView: View {
    @State private var products: [Product] = [
        Product(
            title: "РУЛЬ ЛЕКСУСА GX470 2009Г. НОВЫЙ",
            description: "Левый руль. Контрактный, без пробега по КП. Lexus GX470 1 поколение (01.2002 - 07.2009) Гарантия...",
            price: "7 000с",
            image: "onboard1", // Replace with your image
            views: 21,
            comments: 12,
            likes: 456,
            timeLeft: "4ч.н."
        ),
        Product(
            title: "BOSS BOTTLING",
            description: "Масляный аромат, стойкий на 12 часов, подходит для мужчин и женщин.",
            price: "3 500с",
            image: "onboard2", // Replace with your image
            views: 15,
            comments: 5,
            likes: 220,
            timeLeft: "6ч.н."
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Filters
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    FilterButton(title: "МАРКА")
                    FilterButton(title: "ЦЕНА")
                    FilterButton(title: "СОСТОЯНИЕ")
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 10)
            
            // Product List
            ScrollView {
                LazyVStack {
                    ForEach(products) { product in
                        ProductRow(product: product)
                            .padding(.vertical, 10)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct FilterButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .bold))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.yellow)
            .cornerRadius(20)
    }
}

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Product Image
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(10)
            
            // Product Title
            Text(product.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .lineLimit(2)
            
            // Category and Description
            Text("КАТЕГОРИЯ: РУЛЕВЫЕ ЗАПЧАСТИ")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
            
            Text(product.description)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .lineLimit(2)
            
            // Footer with stats
            HStack {
                Text(product.price)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.red)
                
                Spacer()
                
                HStack(spacing: 10) {
                    Label("\(product.views)", systemImage: "eye.fill")
                    Label("\(product.comments)", systemImage: "message.fill")
                    Label("\(product.likes)", systemImage: "heart.fill")
                    Label(product.timeLeft, systemImage: "clock.fill")
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    SearchResultView()
}
