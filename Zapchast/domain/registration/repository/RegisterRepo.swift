//
//  RegisterRepo.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation

protocol RegisterRepo {
    func fetchRegister(password2: String, model: RegisterModel, completion: @escaping (Result<RegisterModel, Error>) -> Void)
    func fetchVerify(email: String, code: String, completion: @escaping (Result<String, Error>) -> Void)
    func fetchLogin(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void)
    func fetchCategories(search: String?, ordering: String?, completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    func fetchProfile(token: String, completion: @escaping (Result<ProfileModel, Error>) -> Void)
}
