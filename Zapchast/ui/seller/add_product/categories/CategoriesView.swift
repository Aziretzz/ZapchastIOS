//
//  CategoriesView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 14/9/24.
//

import SwiftUI

struct CategoriesView: View {
    @State private var categories: [Category] = []
    @State private var isLoading = false
    @State private var page = 1
    
    private var num = 1
    var body: some View {
        VStack {
//
//            // Верхняя панель
//            ZStack {
//                Color(hex: "#232A40")
//                    .ignoresSafeArea(edges: .top)
//                    .frame(height: 100)
//                
//                Text("Категории")
//                    .font(.system(size: 24, weight: .bold))
//                    .foregroundColor(.white)
//            }
//            .frame(maxWidth: .infinity)
//            
            if num == 1 {
                
                HStack {
                    Button(action: {
                        // Действие при нажатии кнопки
                    }) {
                        HStack {
                            // Иконка руля
                            Image(systemName: "steeringwheel")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30) // Размер иконки
                                .foregroundColor(.orange) // Цвет иконки
                            
                            Spacer().frame(width: 12)
                            
                            // Текст кнопки
                            Text("ДЕТАЛИ ДЛЯ РУЛЯ")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black) // Цвет текста
                            
                            Spacer().frame(width: 20)
                            
                        }
                        .padding()
                        .background(Color.yellow) // Цвет фона
                        .clipShape(RoundedCorners(topRight: 20, bottomRight: 20))
                    }
                    .buttonStyle(PlainButtonStyle()) // Убираем стандартный стиль кнопки
                    
                    Spacer()
                }
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(categories) { category in
                        HStack {
                            Text(category.name)
                                .font(.system(size: 16, weight: .bold))
                                .padding()
                            Spacer()
                            Image(systemName: "arrow.right.circle")
                                .padding(.trailing)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding(.horizontal, 16)
                    }
                    
                    if isLoading {
                        ProgressView()
                            .padding(.vertical)
                    }
                }
                .onAppear {
                    loadCategories()
                }
                .onAppear {
                    loadMoreCategoriesIfNeeded(currentCategory: categories.last)
                }
            }
        }
        
    
    }
    // Function to load categories with pagination
    func loadCategories() {
        guard !isLoading else { return }
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newCategories = (1...20).map { index in
                Category(name: "Категория \(index + (page - 1) * 10)")
            }
            self.categories.append(contentsOf: newCategories)
            self.isLoading = false
            self.page += 1
        }
    }
    
    func loadMoreCategoriesIfNeeded(currentCategory: Category?) {
        guard let currentCategory = currentCategory else { return }
        
        let thresholdIndex = categories.index(categories.endIndex, offsetBy: -3)
        if categories.firstIndex(where: { $0.id == currentCategory.id }) == thresholdIndex {
            loadCategories()
        }
    }
}

#Preview {
    CategoriesView()
}
