//
//  SecurityService.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation

protocol SecurityService {
    func getToken() -> String?
    func saveToken(_ token: String)
    func getId() -> String?
    func saveId(_ id: Int)
    func isInit() -> Bool
    func clearCredentials()
    func getVip() -> Bool?
    func saveVip(_ vip: Bool)
    func saveLanguage(_ lun: String)
    func getLanguage() -> String?
    
    func saveSeller(_ isSeller: Bool)
    func isSeller() -> Bool?
    
    func saveShow(_ show: Bool)
    func isShow() -> Bool?
    
    func getEmail() -> String?
    func saveEmail(_ email: String)
}
