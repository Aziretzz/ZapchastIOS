//
//  OnBoardViewModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 15/9/24.
//

import Foundation

class OnBoardViewModel: ObservableObject {
    
    private var service: RegisterRepo
    private var prefs: SecurityService
    
    init(service: RegisterRepo = RegisterRepoImpl()) {
        self.service = service
        prefs = KeychainSecurityService()
    }
    
    func isSeller() -> Bool? {
        return prefs.isSeller()
    }
    
    func isShow() -> Bool? {
        return prefs.isShow()
    }
    
    
    
    @Published var isUserLoggedIn = true
        
        func logout() {
            isUserLoggedIn = false
        }
        
        func login() {
            isUserLoggedIn = true
        }
    
}
