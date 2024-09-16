//
//  RoleViewModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation

class RoleViewModel: ObservableObject {
    
    private var service: RegisterRepo
    private var prefs: SecurityService
    
    init(service: RegisterRepo = RegisterRepoImpl()) {
        self.service = service
        prefs = KeychainSecurityService()
    }
    
    func setSeller(isSeller: Bool) {
        prefs.saveSeller(isSeller)
    }
    
}
