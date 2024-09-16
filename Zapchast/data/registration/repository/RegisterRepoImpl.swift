//
//  RegisterRepoImpl.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 16/9/24.
//

import Foundation


class RegisterRepoImpl: RegisterRepo {
    
    
    func fetchRegister(password2: String, model: RegisterModel, completion: @escaping (Result<RegisterModel, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: "https://zapchast.com.kg/api/users/register/") else {
            let error = NSError(domain: "URLComponentsError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать URLComponents"])
            completion(.failure(error))
            return
        }
        guard let url = urlComponents.url else {
            let error = NSError(domain: "URLError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Не удалось получить URL из URLComponents"])
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let bodyParameters = [
            "username": model.username,
            "password": model.password,
            "password2": password2,
            "email": model.email,
            "phone_number": model.phone_number,
            "user_type": model.user_type
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Обработка ошибки запроса
            if let error = error {
//                completion(.failure(error))
                return
            }
            
            // Проверка ответа и данных
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                let error = NSError(domain: "NetworkError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет данных или некорректный ответ сервера"])
//                completion(.failure(error))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                // Успешный ответ, декодируем данные
                do {
                    let decoder = JSONDecoder()
                    let registerModel = try decoder.decode(RegisterModel.self, from: data)
                    completion(.success(registerModel))
                } catch {
                    completion(.failure(error))
                }
            } else {
                // Ошибка с сервера, пытаемся декодировать сообщение
                do {
                    if let errorResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        var errorMessage = ""

                        // Проверка ошибок для каждого поля
                        if let usernameErrors = errorResponse["username"] as? [String], let firstUsernameError = usernameErrors.first {
                            errorMessage += "Username: \(firstUsernameError)\n"
                        }
                        if let emailErrors = errorResponse["email"] as? [String], let firstEmailError = emailErrors.first {
                            errorMessage += "Email: \(firstEmailError)\n"
                        }
                        if let passwordErrors = errorResponse["password"] as? [String], let firstPasswordError = passwordErrors.first {
                            errorMessage += "Password: \(firstPasswordError)\n"
                        }
                        
                        
                        if !errorMessage.isEmpty {
                            let error = NSError(domain: "ServerError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//                            completion(.success(error))
                        } else {
                            let error = NSError(domain: "ServerError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Некорректный формат ошибки с сервера"])
//                            completion(.success(error))
                        }
                    } else {
                        let error = NSError(domain: "ServerError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Некорректный формат ошибки с сервера"])
//                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    func fetchVerify(email: String, code: String, completion: @escaping (Result<String, Error>) -> Void) {
        // URL для запроса
        guard let url = URL(string: "https://zapchast.com.kg/api/users/verify-email/") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Параметры запроса
        let parameters = [
            "email": email,
            "code": code
        ]
        
        // Создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Преобразование параметров в x-www-form-urlencoded формат
        let bodyString = parameters.compactMap { "\($0)=\($1)" }.joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)
        
        // Создание сессии для выполнения запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверка на наличие ошибок
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Проверка корректности ответа
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data = data else {
                let errorMessage = "Invalid response or data"
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            // Попытка декодировать JSON ответ
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = json["message"] as? String {
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume() // Запуск запроса
        
        
    }
    
    
    func fetchLogin(email: String, password: String, completion: @escaping (Result<LoginModel, any Error>) -> Void) {
        // URL для запроса
        guard let url = URL(string: "https://zapchast.com.kg/api/users/login/") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Параметры запроса
        let parameters = [
            "email": email,
            "password": password
        ]
        
        // Создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Преобразование параметров в x-www-form-urlencoded формат
        let bodyString = parameters.map { "\($0)=\($1)" }.joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)
        
        // Создание сессии для выполнения запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверка на наличие ошибок
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Проверка корректности ответа
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data = data else {
                let errorMessage = "Invalid response or data"
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            // Попытка декодировать JSON ответ
            do {
                let loginModel = try JSONDecoder().decode(LoginModel.self, from: data)
                completion(.success(loginModel))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume() // Запуск запроса
    }
    
    
    
    func fetchCategories(search: String?, ordering: String?, completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        // Формируем URL
        var urlComponents = URLComponents(string: "https://zapchast.com.kg/api/products/categories/")!
        
        // Добавляем параметры запроса
        var queryItems: [URLQueryItem] = []
        if let search = search {
            queryItems.append(URLQueryItem(name: "search", value: search))
        }
        if let ordering = ordering {
            queryItems.append(URLQueryItem(name: "ordering", value: ordering))
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Создаём запрос
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Создаём сессию
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверка на ошибки
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Проверка ответа
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data = data else {
                let errorMessage = "Invalid response or data"
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            // Парсинг JSON
            do {
                let categories = try JSONDecoder().decode([CategoryModel].self, from: data)
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume() // Выполняем запрос
    }
    
    
    func fetchProfile(token: String, completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        // URL для запроса
        guard let url = URL(string: "https://zapchast.com.kg/api/users/profile/") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Создаём сессию
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверка на наличие ошибок
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Проверка корректности ответа
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data = data else {
                let errorMessage = "Invalid response or data"
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            // Парсинг JSON
            do {
                let userProfile = try JSONDecoder().decode(ProfileModel.self, from: data)
                completion(.success(userProfile))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume() // Выполняем запрос
    }
}
