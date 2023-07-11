//
//  NetworkManager.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//
import Alamofire
import UIKit

protocol Network: AnyObject {
    static func auth(email: String?, password: String?, completion:@escaping (()->()))
    static func getFilterOptions(completion: @escaping (()->()))
    static func logout(completion: @escaping (()->()))
    static func passwordRestoreByEmail(email: String, completion: @escaping (()->()))
    static func passwordRestoreByCode(email: String, newPassword: String, code: String, completion: @escaping (()->()))
    static func register(signUpDataModel:SignUpDataModel, completion: @escaping (()->()))


    static func getListOfLessons(completion: @escaping ((LessonsListModel)->()))

    static func getQuestionList(completion: @escaping ((QuestionsListModel)->()))
    static func getUserMe(completion: @escaping ((UserInfoModel) -> ()))
    static func userListenedCreate(lessonId: Int, durationSeconds: Int,completion: @escaping (() -> ()))
    static func getUserListened(completion: @escaping (([UserListenedListModel]) -> ()))
    static func createUserTags(tagId: [Int],completion: @escaping (() -> ()))
    static func getListUserTags(completion: @escaping (() -> ()))
    
    static func getImage(imageUrl: String, completion: @escaping ((UIImage) -> ()))
}

enum Headers {
    static let authHeaders: [String: String] = ["Accept":"application/json"]
    static let headers: [String: String] = ["Accept":"application/json",
                                            "Authorization":"Bearer \(UserDefaultsManager.getToken() ?? "")"]
}

class NetworkManager: Network {
    
    private enum Api {
        static let baseUrlNoApi = "http://srv46749.ht-test.ru/"
        static let baseUrl = "http://srv46749.ht-test.ru/api/"
        static let auth = baseUrl + "auth"
        static let logout = baseUrl + "logout"
        static let passwordRestoreByEmail = baseUrl + "password/restoreByEmail"
        static let passwordRestoreByCode = baseUrl + "password/restoreByCode"
        static let register = baseUrl + "register"
        
        
        static let getListOfLessons = baseUrl + "lesson/list"
        static let filterOptions = baseUrl + "filter/options"
        
        static let getQuestionList = baseUrl + "question/list"
        
        static let getSectionList = baseUrl + "section/list"
        
        //user
        static let getUserMe = baseUrl + "user/get/me"
        static let userlistenedCreate = baseUrl + "user/listened/create"
        static let getUserlistened = baseUrl + "user/listened/get"
        static let createUserTags = baseUrl + "user/tags/create"
        static let getListUserTags = baseUrl + "user/tags/list"
    }
    
    fileprivate static func requestLog(method: HTTPMethod, url: URL, data: Data?) {
        print("⬆️ Request:", "\n",
              "Method:", method.rawValue, "\n",
              "URL:", url, "\n",
              "Data:", String(data: data ?? Data(), encoding: .utf8) ?? "", "\n")
    }
    
    fileprivate static func responseLog(satusCode: Int?, data: Data?, url: URL) {
        print("⬇️ Response:", "\n",
              "Status code:", satusCode ?? "000", "\n",
              "URL: ", "\(url)", "\n",
              "Data:", dataToString(data: data), "\n")
    }
    
    fileprivate static func dataToString(data: Data?) -> String {
        guard let data = data else {
            return "null"
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                return  ("errorMsg")
            }
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let convertedString = String(data: data1, encoding: .utf8)
            return convertedString ?? "null"
        } catch {
            print("errorMsg")
        }
        return "null"
    }
    
    static func showError(errorText: String) {
        DispatchQueue.main.async {
            let errorView = CustomAlertView(title: CommonString.error, subtitle: errorText, button: CustomAlertView.Button(title: CommonString.ok, action: { }))
            UIApplication.shared.windows.first?.rootViewController?.view.addSubview(errorView)
        }
    }
    
    fileprivate static func request(url: URL, method: HTTPMethod, parameters: [String: Any]?, success: @escaping (Data)->()) {
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters ?? [:], options: .prettyPrinted)
        requestLog(method: method, url: url, data: jsonData)
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).responseData { (response) in
            responseLog(satusCode: response.response?.statusCode, data: response.data, url: url)
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    showError(errorText: "NO DATA")
                    return
                }
                success(data)
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    
    static func getImage(imageUrl: String, completion: @escaping ((UIImage) -> ())) {
        guard let url = URL(string: Api.baseUrlNoApi + imageUrl) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let image = UIImage(data: data) else {
                showError(errorText: "\(url) - нет картинки")
                return
            }
            completion(image)
        }
//        AF.request(url,
//                   method: .get,
//                   parameters: nil,
//                   encoding: URLEncoding.default,
//                   headers: HTTPHeaders(Headers.headers),
//                   interceptor: nil,
//                   requestModifier: nil).response { (response) in
//            responseLog(satusCode: response.response?.statusCode, data: response.data, url: url)
//            switch response.result {
//            case .success(_):
//                guard let data = try? response.data else {
//                    showError(errorText: "\(url) - no data")
//                    return
//                }
//                guard let image = try? UIImage(data: data) else {
//                    showError(errorText: "\(url) - нет картинки")
//                    return
//                }
//                completion(image)
//            case .failure(let error):
//                showError(errorText: error.errorDescription ?? CommonString.unknownError)
//            }
//        }
    }

    //MARK: - Auth
    
    static func auth(email: String?, password: String?, completion: @escaping (()->())) {
        guard let email = email else { return }
        guard let password = password else { return }
        guard let url = URL(string: Api.auth + "?email=\(email)&password=\(password)&device=ios") else { return }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.authHeaders),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
                    guard let message = errorModel.message else {
                        showError(errorText: errorModel.message ?? CommonString.emptyToken)
                        return
                    }
                    UserDefaultsManager.setToken(token: message)
                    completion()
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    static func logout(completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.logout) else { return }
        request(url: url, method: .post, parameters: nil) { data in
            guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) else {
                showError(errorText: CommonString.wrongModel)
                return
            }
            if errorModel.error == true {
                showError(errorText: errorModel.message ?? CommonString.unknownError)
            } else {
                completion()
            }
        }
//        AF.request(url,
//                   method: .post,
//                   parameters: nil,
//                   encoding: URLEncoding.default,
//                   headers: HTTPHeaders(Headers.headers),
//                   interceptor: nil,
//                   requestModifier: nil).response { (response) in
//            switch response.result {
//            case .success(_):
//                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
//                    showError(errorText: CommonString.wrongModel)
//                    return
//                }
//                if errorModel.error == true {
//                    showError(errorText: errorModel.message ?? CommonString.unknownError)
//                } else {
//                    completion()
//                }
//            case .failure(let error):
//                showError(errorText: error.errorDescription ?? CommonString.unknownError)
//            }
//        }
    }
    
    static func passwordRestoreByEmail(email: String, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.passwordRestoreByEmail) else { return }
        let parameters: [String: Any] = ["email":email]
        request(url: url, method: .post, parameters: parameters) { data in
            guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) else {
                showError(errorText: CommonString.wrongModel)
                return
            }
            if errorModel.error == true {
                showError(errorText: errorModel.message ?? CommonString.unknownError)
            } else {
                completion()
            }
        }
//        AF.request(url,
//                   method: .post,
//                   parameters: parameters,
//                   encoding: URLEncoding.default,
//                   headers: HTTPHeaders(Headers.headers),
//                   interceptor: nil,
//                   requestModifier: nil).response { (response) in
//            switch response.result {
//            case .success(_):
//                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
//                    showError(errorText: CommonString.wrongModel)
//                    return
//                }
//                if errorModel.error == true {
//                    showError(errorText: errorModel.message ?? CommonString.unknownError)
//                } else {
//                    completion()
//                }
//            case .failure(let error):
//                showError(errorText: error.errorDescription ?? CommonString.unknownError)
//            }
//        }
    }
    
    static func passwordRestoreByCode(email: String, newPassword: String, code: String, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.passwordRestoreByCode) else { return }
        let parameters: [String: Any] = ["email": email,
                                         "password": newPassword,
                                         "code": code]
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
                    completion()
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    
    static func register(signUpDataModel: SignUpDataModel, completion: @escaping (()->())) {
        guard let url = URL(string: Api.register) else { return }
        let parameters: [String: Any] = ["name":signUpDataModel.name ?? "",
                                         "email":signUpDataModel.email ?? "",
                                         "phone":signUpDataModel.phone ?? "",
                                         "password":signUpDataModel.password ?? ""]
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
//                    guard let message = errorModel.message else {
//                        showError(errorText: errorModel.message ?? CommonString.emptyToken)
//                        return
//                    }
                    completion()
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }

    
    
    //MARK: - Filter
    
    static func getFilterOptions(completion: @escaping (()->())) {
        guard let url = URL(string: Api.filterOptions) else { return }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
                    guard let message = errorModel.message else {
                        showError(errorText: errorModel.message ?? CommonString.emptyToken)
                        return
                    }
                    completion()
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    
    //MARK: -  Lesson
    
    static func getListOfLessons(completion: @escaping ((LessonsListModel) -> ())) {
        guard let url = URL(string: Api.getListOfLessons) else { return }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
                    
                    guard let data = try? JSONDecoder().decode(LessonsListModel.self, from: response.data!) else {
                        showError(errorText: "\(url) \(CommonString.wrongModel)")
                        return
                    }
                    completion(data)
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    //MARK: -  Question
    
    static func getQuestionList(completion: @escaping ((QuestionsListModel) -> ())) {
        guard let url = URL(string: Api.getQuestionList) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let data = try? JSONDecoder().decode(QuestionsListModel.self, from: data) else {
                showError(errorText: "\(url)-\(CommonString.wrongModel)")
                return
            }
            completion(data)
        }
//        AF.request(url,
//                   method: .get,
//                   parameters: nil,
//                   encoding: URLEncoding.default,
//                   headers: HTTPHeaders(Headers.headers),
//                   interceptor: nil,
//                   requestModifier: nil).response { (response) in
//            switch response.result {
//            case .success(_):
//                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
//                    showError(errorText: CommonString.wrongModel)
//                    return
//                }
//                if errorModel.error == true {
//                    showError(errorText: errorModel.message ?? CommonString.unknownError)
//                } else {
//                    guard let data = try? JSONDecoder().decode(QuestionsListModel.self, from: response.data!) else {
//                        showError(errorText: CommonString.wrongModel)
//                        return
//                    }
//                    completion(data)
//                }
//            case .failure(let error):
//                showError(errorText: error.errorDescription ?? CommonString.unknownError)
//            }
//        }
    }
    
    //MARK: -  Section
    
    static func getSectionList(completion: @escaping ((QuestionsListModel) -> ())) {
        guard let url = URL(string: Api.getSectionList) else { return }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
                    guard let data = try? JSONDecoder().decode(QuestionsListModel.self, from: response.data!) else {
                        showError(errorText: CommonString.wrongModel)
                        return
                    }
                    completion(data)
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    //MARK: -  User
    
    static func getUserMe(completion: @escaping ((UserInfoModel) -> ())) {
        guard let url = URL(string: Api.getUserMe) else { return }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
                    guard let data = try? JSONDecoder().decode(UserInfoModel.self, from: response.data!) else {
                        showError(errorText: CommonString.wrongModel)
                        return
                    }
                    completion(data)
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    static func userListenedCreate(lessonId: Int, durationSeconds: Int,completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.userlistenedCreate) else { return }
        let parameters: [String: Any] = ["lesson_id": lessonId,
                                         "duration_seconds": durationSeconds]
//        let parameters: [String: Any] = [:]
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
//                    guard let data = try? JSONDecoder().decode(UserInfoModel.self, from: response.data!) else {
//                        showError(errorText: CommonString.wrongModel)
//                        return
//                    }
                    completion()
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    static func getUserListened(completion: @escaping (([UserListenedListModel]) -> ())) {
        guard let url = URL(string: Api.getUserlistened) else { return }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
//                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
//                    showError(errorText: CommonString.wrongModel)
//                    return
//                }
//                if errorModel.error == true {
//                    showError(errorText: errorModel.message ?? CommonString.unknownError)
//                } else {
                    guard let data = try? JSONDecoder().decode([UserListenedListModel].self, from: response.data!) else {
                        showError(errorText: CommonString.wrongModel)
                        return
                    }
                    completion(data)
//                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    static func createUserTags(tagId: [Int], completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.createUserTags) else { return }
        let parameters: [String: Any] = ["tag_id": tagId]
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
                    showError(errorText: CommonString.wrongModel)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                } else {
                    completion()
                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    
    static func getListUserTags(completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.getListUserTags) else { return }
//        let parameters: [String: Any] = ["tag_id": tagId]
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers.headers),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            switch response.result {
            case .success(_):
//                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) else {
//                    showError(errorText: CommonString.wrongModel)
//                    return
//                }
//                if errorModel.error == true {
//                    showError(errorText: errorModel.message ?? CommonString.unknownError)
//                } else {
//                    guard let data = try? JSONDecoder().decode([UserListenedListModel].self, from: response.data!) else {
//                        showError(errorText: CommonString.wrongModel)
//                        return
//                    }
                    completion()
//                }
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
}
