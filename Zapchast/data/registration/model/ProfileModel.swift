//
//  ProfileModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation


struct ProfileModel: Codable {
    let id: Int
    let username: String
    let email: String
    let phoneNumber: String
    let userType: String
    let emailVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case phoneNumber = "phone_number"
        case userType = "user_type"
        case emailVerified = "email_verified"
    }
}
