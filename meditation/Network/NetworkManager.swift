//
//  NetworkManager.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//
import Alamofire
import UIKit

protocol Network: AnyObject {
    //auth
    static func auth(email: String?, password: String?, completion:@escaping (()->()))
    static func getFilterOptions(completion: @escaping (()->()))
    static func logout(completion: @escaping (()->()))
    static func passwordRestoreByEmail(email: String, completion: @escaping (()->()))
    static func passwordRestoreByCode(email: String, newPassword: String, code: String, completion: @escaping (()->()))
    static func register(signUpDataModel:SignUpDataModel, completion: @escaping (()->()))
    static func getQuestionList(completion: @escaping ((QuestionsListModel)->()))
    //lesson
    static func getListOfLessons(completion: @escaping ((LessonsListModel)->()))
    static func getSectionList(completion: @escaping ((SectionListModel) -> ()))
    static func getSection(id: Int, completion: @escaping ((SectionModel) -> ()))
    static func getLesson(id: Int, completion: @escaping ((LessonsListDataModel) -> ()))
    //user
    static func getUserMe(completion: @escaping ((UserInfoModel) -> ()))
    static func userListenedCreate(lessonId: Int, durationSeconds: Int, isFinishLesson: Int?, completion: @escaping (() -> ()))
    static func getUserListened(completion: @escaping ((UserListenedListModel) -> ()))
    static func createUserTags(tagId: [Int],completion: @escaping (() -> ()))
    static func getListUserTags(completion: @escaping (() -> ()))
    static func createUserAvatar(image: UIImage, completion: @escaping (() -> ()))
    static func getUserAvatar(completion: @escaping ((String) -> ()))
    static func deleteUserAvatar(completion: @escaping (() -> ()))
    static func deleteUser(completion: @escaping (() -> ()))
    static func updateUser(id: Int, name: String?, email: String?, phone: Int?, completion: @escaping (() -> ()))
    //favorite
    static func createFavoriteList(lessonId: Int, completion: @escaping (() -> ()))
    static func getFavoriteList(completion: @escaping (([FavoriteModel]) -> ()))
    static func deleteFavoriteList(lessonId: Int, completion: @escaping (() -> ()))
    
    static func getSettingsList(completion: @escaping ((SettingsListModel) -> ()))
    //getFile
    static func getImage(imageUrl: String?, completion: @escaping ((UIImage) -> ()))
    static func getVideo(videoUrl: String?, completion: @escaping ((URL) -> ()))
    static func getAudio(url: String?, completion: @escaping ((Data) -> ()))
}

class NetworkManager: Network, RequestInterceptor {
    private enum Api {
        static let baseUrlNoApi = "https://mp.swarz.beget.tech/"//"http://srv46749.ht-test.ru/"
        static let baseUrl = "https://mp.swarz.beget.tech/api/"//"http://srv46749.ht-test.ru/api/"
        //auth
        static let auth = baseUrl + "auth"
        static let logout = baseUrl + "logout"
        static let passwordRestoreByEmail = baseUrl + "password/restoreByEmail"
        static let passwordRestoreByCode = baseUrl + "password/restoreByCode"
        static let register = baseUrl + "register"
        static let getQuestionList = baseUrl + "question/list"
        //lesson
        static let getListOfLessons = baseUrl + "lesson/list"
        static let getSectionList = baseUrl + "section/list"
        static let getSection = baseUrl + "section/get"
        static let getLesson = baseUrl + "lesson/get"
        //user
        static let getUserMe = baseUrl + "user/get/me"
        static let userlistenedCreate = baseUrl + "user/listened/create"
        static let getUserlistened = baseUrl + "user/listened/get"
        static let createUserTags = baseUrl + "user/tags/create"
        static let getListUserTags = baseUrl + "user/tags/list"
        static let createUserAvatar = baseUrl + "user/avatar/create"
        static let getUserAvatar = baseUrl + "user/avatar/get"
        static let deleteUserAvatar = baseUrl + "user/avatar/delete"
        static let deleteUser = baseUrl + "user/delete"
        static let updateUser = baseUrl + "user/update"
        
        //favorite
        static let getFavoriteList = baseUrl + "favorite/list"
        static let createFavoriteList = baseUrl + "favorite/create"
        static let deleteFavoriteList = baseUrl + "favorite/delete"
        
        static let getSettingsList = baseUrl + "settings/list"
        
        static let filterOptions = baseUrl + "filter/options"
    }
    
    struct Headers {
        let authHeader: [String: String] = ["Accept":"application/json"]
        let header: [String: String] = ["Accept":"application/json",
                                        "Authorization":"Bearer \(UserDefaultsManager.getToken() ?? "")"]
    }
    
    private let retryLimit = 5
    
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
            return "null data "
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                return  ("error jsonObject")
            }
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let convertedString = String(data: data1, encoding: .utf8)
            return convertedString ?? "null"
        } catch {
            print("error JSONSerialization")
        }
        return "null dataToString "
    }
    
    static func showError(errorText: String) {
        DispatchQueue.main.async {
            let errorView = CustomAlertView(title: CommonString.error, subtitle: errorText, button: CustomAlertView.Button(title: CommonString.ok, action: { }))
            UIApplication.shared.windows.first?.rootViewController?.view.addSubview(errorView)
        }
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else { return }
           switch statusCode {
           case 200...299:
               completion(.doNotRetry)
           default:
               if request.retryCount < retryLimit {
                   completion(.retry)
                   return
               }
               completion(.doNotRetry)
           }
    }
//    fileprivate static func retry(url: URL, method: HTTPMethod, parameters: [String: Any]?, success: @escaping (Data)->()) {
//        request(url: url, method: method, parameters: parameters) { data in
//            success(data)
//        }
//    }
    
    fileprivate static func request(url: URL, method: HTTPMethod, parameters: [String: Any]?, success: @escaping (Data)->()) {
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters ?? [:], options: .prettyPrinted)
        requestLog(method: method, url: url, data: jsonData)
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers().header),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            responseLog(satusCode: response.response?.statusCode, data: response.data, url: url)
            if response.response?.statusCode == 401 {
                guard let window = UIApplication.shared.windows.first else { return }
                ModuleRouter.setRootSignUpModule(window: window)
            }
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    print("no Data in response")
                    return success(Data())
                }
                guard let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data ) else {
                    success(data)
                    return
                }
                if errorModel.error == true {
                    showError(errorText: errorModel.message ?? CommonString.unknownError)
                    return
                }
                success(data)
            case .failure(let error):
                showError(errorText: error.errorDescription ?? CommonString.unknownError)
            }
        }
    }
    
    static func getImage(imageUrl: String?, completion: @escaping ((UIImage) -> ())) {
        guard let imageUrl = imageUrl else { return }
        if imageUrl == "" { return }
        guard let url = URL(string: Api.baseUrlNoApi + imageUrl) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let image = UIImage(data: data) else {
//                showError(errorText: "\(url) - нет картинки")
                return
            }
            completion(image)
        }
    }
    
    static func getVideo(videoUrl: String?, completion: @escaping ((URL) -> ())) {
        guard let videoUrl = videoUrl else { return }
        if videoUrl == "" { return }
        guard let url = URL(string: Api.baseUrlNoApi + videoUrl) else { return }
        request(url: url, method: .get, parameters: nil) { data in
//            guard let videoURL = URL(dataRepresentation: data, relativeTo: url) else { return }
            completion(data.convertToURL())
//            completion(videoURL)
        }
//        guard let videoURL = URL(string: "https://avtshare01.rz.tu-ilmenau.de/avt-vqdb-uhd-1/test_1/segments/cutting_orange_tuil_750kbps_360p_59.94fps_h264.mp4") else { return }
//
//        completion(videoURL)
    }
    
    static func getAudio(url: String?, completion: @escaping ((Data) -> ())) {
        guard let audioUrl = url else { return }
        if audioUrl == "" { return }
        guard let url = URL(string: Api.baseUrlNoApi + audioUrl) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            completion(data)
        }
    }
    
    static func baseUrl() -> String {
        Api.baseUrlNoApi
    }

    //MARK: - Auth
    
    static func auth(email: String?, password: String?, completion: @escaping (()->())) {
        guard let email = email else { return }
        guard let password = password else { return }
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else { return }
        guard let url = URL(string: Api.auth + "?email=\(email)&password=\(password)&device=ios&token_device=\(deviceId)") else { return }
        requestLog(method: .get, url: url, data: nil)
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: HTTPHeaders(Headers().authHeader),
                   interceptor: nil,
                   requestModifier: nil).response { (response) in
            responseLog(satusCode: response.response?.statusCode, data: response.data, url: url)
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
            completion()
        }
    }
    
    static func passwordRestoreByEmail(email: String, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.passwordRestoreByEmail) else { return }
        let parameters: [String: Any] = ["email":email]
        request(url: url, method: .post, parameters: parameters) { data in
            completion()
        }
    }
    
    static func passwordRestoreByCode(email: String, newPassword: String, code: String, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.passwordRestoreByCode) else { return }
        let parameters: [String: Any] = ["email": email,
                                         "password": newPassword,
                                         "code": code]
        request(url: url, method: .post, parameters: parameters) { data in
            completion()
        }
    }
    
    
    static func register(signUpDataModel: SignUpDataModel, completion: @escaping (()->())) {
        guard let url = URL(string: Api.register) else { return }
        let parameters: [String: Any] = ["name":signUpDataModel.name ?? "",
                                         "email":signUpDataModel.email ?? "",
                                         "phone":signUpDataModel.phone ?? "",
                                         "password":signUpDataModel.password ?? ""]
        request(url: url, method: .post, parameters: parameters) { data in
            completion()
        }
    }

    //MARK: - Filter
    
    static func getFilterOptions(completion: @escaping (()->())) {
        guard let url = URL(string: Api.filterOptions) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            completion()
        }
    }
    
    //MARK: -  Lesson
    
    static func getListOfLessons(completion: @escaping ((LessonsListModel) -> ())) {
        guard let url = URL(string: Api.getListOfLessons) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let data = try? JSONDecoder().decode(LessonsListModel.self, from: data) else {
                showError(errorText: "\(url) -> \(CommonString.wrongModel)")
                return
            }
            completion(data)
        }
    }
    
    //MARK: -  Question
    
    static func getQuestionList(completion: @escaping ((QuestionsListModel) -> ())) {
        guard let url = URL(string: Api.getQuestionList) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let data = try? JSONDecoder().decode(QuestionsListModel.self, from: data) else {
                showError(errorText: "\(url) -> \(CommonString.wrongModel)")
                return
            }
            completion(data)
        }
    }
    
    //MARK: -  Section
    
    static func getSectionList(completion: @escaping ((SectionListModel) -> ())) {
        guard let url = URL(string: Api.getSectionList) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let data = try? JSONDecoder().decode(SectionListModel.self, from: data) else {
                showError(errorText: "\(url) -> \(CommonString.wrongModel)")
                return
            }
            completion(data)
        }
    }
    
    static func getSection(id: Int, completion: @escaping ((SectionModel) -> ())) {
        guard let url = URL(string: Api.getSection + "/\(id)") else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let data = try? JSONDecoder().decode(SectionModel.self, from: data) else {
                showError(errorText: "\(url) -> \(CommonString.wrongModel)")
                return
            }
            completion(data)
        }
    }
    
    static func getLesson(id: Int, completion: @escaping ((LessonsListDataModel) -> ())) {
        guard let url = URL(string: Api.getLesson + "/\(id)") else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let model = try? JSONDecoder().decode(LessonsListDataModel.self, from: data) else {
                showError(errorText: "\(url) -> \(CommonString.wrongModel)")
                return
            }
            completion(model)
        }
    }
    
    //MARK: -  User
    
    static func getUserMe(completion: @escaping ((UserInfoModel) -> ())) {
        guard let url = URL(string: Api.getUserMe) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let model = try? JSONDecoder().decode(UserInfoModel.self, from: data) else {
                showError(errorText: "\(url) \(CommonString.wrongModel)")
                return
            }
            UserDefaultsManager.setUserInfo(info: data)
            completion(model)
        }
    }
    
    static func userListenedCreate(lessonId: Int, durationSeconds: Int, isFinishLesson: Int?, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.userlistenedCreate) else { return }
        let parameters: [String: Any] = ["lesson_id": lessonId,
                                         "duration_seconds": durationSeconds,
                                         "listened": isFinishLesson ?? 0]
        request(url: url, method: .post, parameters: parameters) { data in
            completion()
        }
    }
    
    static func getUserListened(completion: @escaping ((UserListenedListModel) -> ())) {
        guard let url = URL(string: Api.getUserlistened) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let data = try? JSONDecoder().decode(UserListenedListModel.self, from: data) else {
                showError(errorText: "\(url) \(CommonString.wrongModel)")
                return
            }
            completion(data)
        }
    }
    
    static func createUserTags(tagId: [Int], completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.createUserTags) else { return }
        let parameters: [String: Any] = ["tag_id": tagId]
        request(url: url, method: .post, parameters: parameters) { data in
            completion()
        }
    }
    
    static func getListUserTags(completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.getListUserTags) else { return }
        request(url: url, method: .get, parameters: nil) { data in
//            guard let data = try? JSONDecoder().decode([UserListenedListModel].self, from: data) else {
//                showError(errorText: "\(url) -> \(CommonString.wrongModel)")
//                return
//            }
            completion()
        }
    }
    
    static func createUserAvatar(image: UIImage, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.createUserAvatar) else { return }
        AF.upload(multipartFormData: {
                multipartFormData in
                    if let imageData = image.jpegData(compressionQuality: 0.7) {
                        multipartFormData.append(imageData, withName: "avatar", fileName: "name.png", mimeType: "image/png")
                    }
        },  to: url, method: .post, headers: HTTPHeaders(Headers().header))
        .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .response(completionHandler: { response in
            completion()
       })
    }
    
    static func getUserAvatar(completion: @escaping ((String) -> ())) {
        guard let url = URL(string: Api.getUserAvatar) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let string = String(data: data, encoding: .ascii) else { return }
            completion(string)
        }
    }
    
    static func deleteUserAvatar(completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.deleteUserAvatar) else { return }
        request(url: url, method: .delete, parameters: nil) { data in
            completion()
        }
    }
    
    static func deleteUser(completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.deleteUser) else { return }
        request(url: url, method: .delete, parameters: nil) { data in
            completion()
        }
    }
    
    static func updateUser(id: Int, name: String?, email: String?, phone: Int?, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.updateUser) else { return }
        var parameters: [String: Any] = ["id": id]
        if let name = name {
            parameters["name"] = name
        }
        if let email = email {
            parameters["email"] = email
        }
        if let phone = phone {
            parameters["phone"] = phone
        }
        request(url: url, method: .put, parameters: parameters) { data in
            UserDefaultsManager.setUserInfo(info: data)
            completion()
        }
    }
    
    static func createFavoriteList(lessonId: Int, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.createFavoriteList) else { return }
        let parameters: [String: Any] = ["lesson_id": lessonId]
        request(url: url, method: .post, parameters: parameters) { data in
            completion()
        }
    }
    
    static func getFavoriteList(completion: @escaping (([FavoriteModel]) -> ())) {
        guard let url = URL(string: Api.getFavoriteList) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let data = try? JSONDecoder().decode([FavoriteModel].self, from: data) else {
                showError(errorText: "\(url) -> \(CommonString.wrongModel)")
                return
            }
            completion(data)
        }
    }
    
    static func deleteFavoriteList(lessonId: Int, completion: @escaping (() -> ())) {
        guard let url = URL(string: Api.deleteFavoriteList) else { return }
        let parameters: [String: Any] = ["lesson_id": lessonId]
        request(url: url, method: .delete, parameters: parameters) { data in
            completion()
        }
    }
    
    static func getSettingsList(completion: @escaping ((SettingsListModel) -> ())) {
        guard let url = URL(string: Api.getSettingsList) else { return }
        request(url: url, method: .get, parameters: nil) { data in
            guard let data = try? JSONDecoder().decode(SettingsListModel.self, from: data) else {
                showError(errorText: "\(url) -> \(CommonString.wrongModel)")
                return
            }
            completion(data)
        }
    }
}
