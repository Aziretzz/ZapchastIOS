//
//  RegisterViewModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var registerModel: RegisterModel?
    
    private let dataService = RegisterRepoImpl()
    private var prefs: SecurityService
    @Published var registered = false
    @Published var errorMessage: String? // Для хранения сообщения об ошибке
    @Published var showErrorAlert = false // Для управления отображением алерта
    
    init(service: SecurityService = KeychainSecurityService()) {

        prefs = service
    }
    
    func fetchRegister(model: RegisterModel, password2: String) {
        // Проверка совпадения паролей
        guard model.password == password2 else {
            // Обработка ошибки, если пароли не совпадают
            self.errorMessage = "Пароли не совпадают"
            self.showErrorAlert = true
            return
        }
        
        prefs.saveEmail(model.email)
        
        dataService.fetchRegister(password2: password2, model: model) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.registerModel = posts
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.showErrorAlert = true
            }
        }
        self.registered = true
    }
}
