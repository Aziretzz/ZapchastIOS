//
//  ProfileViewModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profileModel: ProfileModel?
    
    private let dataService = RegisterRepoImpl()
    private var prefs: SecurityService
    @Published var registered = false
    @Published var errorMessage: String? // Для хранения сообщения об ошибке
    @Published var showErrorAlert = false // Для управления отображением алерта
    
    init(service: SecurityService = KeychainSecurityService()) {

        prefs = service
    }
    
    func fetchProfile() {
        dataService.fetchProfile(token: prefs.getToken() ?? "") { [weak self] result in
            switch result {
            case .success(let posts):
                self?.profileModel = posts
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.showErrorAlert = true
            }
        }
    }
    
    func logout() {
        prefs.saveToken("")
        prefs.saveEmail("")
        prefs.saveShow(false)
    }
}
