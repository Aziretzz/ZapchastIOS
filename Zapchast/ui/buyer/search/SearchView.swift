//
//  SearchView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 9/9/24.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    @State private var categories: [Category] = []
    @State private var searchResults: [Category] = []
    @State private var page = 1
    @State private var isLoading = false
    @State private var searchText = ""
    @State private var showSearchResults = false

    var body: some View {
        NavigationView {
            VStack {
                
                // Top bar
                ZStack {
                    Color(hex: "#550486")
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 80)
                    
                    
                    Text("Поиск")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                }
                .frame(maxWidth: .infinity)
                
                // Search Bar
                HStack {
                    TextField("Поиск", text: $searchText, onCommit: {
                        // Trigger search results view
                        showSearchResults = true
                        searchResults = [] // Clear previous results
                        page = 1 // Reset pagination
                        loadSearchResults()
                    })
                    .padding(.leading, 30) // Отступ слева для иконки поиска
                    .padding(.trailing, 40) // Отступ справа для иконки микрофона
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding(.leading, 30) // Иконка лупы ближе к левому краю
                            Spacer()
                            Button(action: {
                                // Handle voice search
                            }) {
                                Image(systemName: "mic.fill")
                                    .foregroundColor(Color(hex: "#550486"))
                                    .padding(.trailing, 30) // Иконка микрофона ближе к правому краю
                            }
                        }
                    )
                }
                .padding(.top, 10)
                
                if showSearchResults {
                    // Добавьте здесь корректный вызов SearchResultView с параметрами
                    SearchResultView()
                } else {
                    // Category List (before search)
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.categoryModel ?? []) { category in
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
                    }
                    .onAppear {
              
                        viewModel.fetchCategories(search: searchText, ordering: "")
                    }
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
    
    // Function to load categories with pagination
    func loadCategories() {
        guard !isLoading else { return }
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newCategories = (1...10).map { index in
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

    // Function to load search results with pagination
    func loadSearchResults() {
        guard !isLoading else { return }
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newResults = (1...10).map { index in
                Category(name: "Результат \(index + (page - 1) * 10) для \"\(searchText)\"")
            }
            self.searchResults.append(contentsOf: newResults)
            self.isLoading = false
            self.page += 1
        }
    }
    
    func loadMoreSearchResultsIfNeeded(currentResult: Category?) {
        guard let currentResult = currentResult else { return }
        
        let thresholdIndex = searchResults.index(searchResults.endIndex, offsetBy: -3)
        if searchResults.firstIndex(where: { $0.id == currentResult.id }) == thresholdIndex {
            loadSearchResults()
        }
    }
}



#Preview {
    SearchView()
}
