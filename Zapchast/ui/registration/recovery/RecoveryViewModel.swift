//
//  RecoveryViewModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation


class RecoveryViewModel: ObservableObject {
    
    private let dataService = RegisterRepoImpl()
    var prefs: SecurityService
    @Published var isVerify = false
    @Published var errorMessage: String? // Для хранения сообщения об ошибке
    @Published var showErrorAlert = false // Для управления отображением алерта
    
    init(service: SecurityService = KeychainSecurityService()) {

        prefs = service
    }
    
    func fetchRecovery(code: String, email: String) {
        dataService.fetchVerify(email: email, code: code) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.isVerify = true
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.showErrorAlert = true
            }
        }
    }
    
}
