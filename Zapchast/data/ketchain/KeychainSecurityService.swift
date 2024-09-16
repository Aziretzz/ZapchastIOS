//
//  KeychainSecurityAccess.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation
import KeychainAccess

class KeychainSecurityService: SecurityService {
    private let keychain = Keychain(service: "com.zapchast.zapchast")

    func getToken() -> String? {
        return keychain["token"]
    }

    func saveToken(_ token: String) {
        keychain["token"] = token
    }
    
    func saveId(_ id: Int) {
        let userId = String(id)
        keychain["id"] = userId
    }
    
    func getId() -> String? {
        return keychain["id"]
    }
    
    func isInit() -> Bool {
        return getToken() != nil
    }
    
    func getVip() -> Bool? {
        return Bool(keychain["vip"] ?? "false")
    }
    
    func saveVip(_ vip: Bool) {
        let v = String(vip)
        keychain["vip"] = v
    }

    func clearCredentials() {
        keychain["token"] = nil
        keychain["id"] = nil
    }
    
    
    func saveLanguage(_ lun: String) {
        keychain["language"] = lun
    }
    
    func getLanguage() -> String? {
        return keychain["language"]
    }
    
    func saveSeller(_ isSeller: Bool) {
        let v = String(isSeller)
        keychain["type"] = v
    }
    
    func isSeller() -> Bool? {
        return Bool(keychain["type"] ?? "false")
    }
    
    func saveShow(_ show: Bool) {
        let s = String(show)
        keychain["show"] = s
    }
    
    func isShow() -> Bool? {
        return Bool(keychain["show"] ?? "false")
    }
    
    func getEmail() -> String? {
        return keychain["email"]
    }
    
    func saveEmail(_ email: String) {
        keychain["email"] = email
    }
    
}
