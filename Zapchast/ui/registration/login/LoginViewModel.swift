//
//  LoginViewModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginModel: LoginModel?
    
    private let dataService = RegisterRepoImpl()
    private var prefs: SecurityService
    @Published var isLogined = false
    @Published var errorMessage: String? // Для хранения сообщения об ошибке
    @Published var showErrorAlert = false // Для управления отображением алерта
    
    init(service: SecurityService = KeychainSecurityService()) {

        prefs = service
    }
    
    func fetchRegister(email: String, password: String) {
        dataService.fetchLogin(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.loginModel = posts
                self?.prefs.saveShow(true)
                // Логин успешен, обновляем состояние
                DispatchQueue.main.async {
                    self?.isLogined = true
                }
                self?.prefs.saveToken(posts.access)
                
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.showErrorAlert = true
            }
        }
    }
    
    
}
