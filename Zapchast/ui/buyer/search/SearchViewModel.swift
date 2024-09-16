//
//  SearchViewModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var categoryModel: [CategoryModel]?
    
    private let dataService = RegisterRepoImpl()
    private var prefs: SecurityService
    @Published var registered = false
    @Published var errorMessage: String? // Для хранения сообщения об ошибке
    @Published var showErrorAlert = false // Для управления отображением алерта
    
    init(service: SecurityService = KeychainSecurityService()) {

        prefs = service
    }
    
    
    func fetchCategories(search: String?, ordering: String?) {
        dataService.fetchCategories(search: search, ordering: ordering) { result in
            switch result {
            case .success(let categories):
                self.categoryModel = categories
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
