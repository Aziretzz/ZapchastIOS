//
//  RegisterModel.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation

struct RegisterModel: Decodable {
    let id: Int
    let username: String
    let password: String?
    let email: String
    let phone_number: String
    let user_type: String
    let email_veryfied: Bool
}
