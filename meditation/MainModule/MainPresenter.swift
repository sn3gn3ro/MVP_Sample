//
//  MainPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import Foundation

protocol MainProtocol: AnyObject {
    func didLoadUserInfo()
    func didLoadListed()
    func didLoadSectionList()
    func didLoadSettings()
    
    func didLoadSettingsVideo()
    func didLoadListedVideo()
    func didLoadRecomendedVideo(index: Int)
    func didLoadSectionsVideo(index: Int)
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainProtocol, dataModel: MainDataModel)
    
    func getData()
    func getUserInfo()
    func getListed()
    func getSectionList()
    func getSettings()
}

class MainPresenter: MainPresenterProtocol {
    weak private var view: MainProtocol?
    var dataModel: MainDataModel
    
    required init(view: MainProtocol, dataModel: MainDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func clearData() {
        dataModel.bufferedRecomended.removeAll()
        dataModel.bufferedSection.removeAll()
        dataModel.bufferedListed = nil
    }
    
    func getData() {
        getUserInfo()
        getSettings()
        getListed()
        getSectionList()
    }
    
    func getSettings() {
        NetworkManager.getSettingsList {  [weak self] settings in
            self?.dataModel.settings = settings
            self?.getVideoFromSettings(link: settings.getCurrentDayLink())
            self?.view?.didLoadSettings()
            //Убрать когда будут рекомендуемые
            for index in 0...2 {
                self?.getVideoFromRecomended(index: index, link: settings.getCurrentDayLink())
            }
        }
    }
    
    func getUserInfo() {
        dataModel.userInfoModel = UserDefaultsManager.getUserInfo()
        NetworkManager.getUserMe { [weak self] userInfo in
            self?.dataModel.userInfoModel = userInfo
            self?.view?.didLoadUserInfo()
        }
    }
    
    func getListed() {
        dataModel.bufferedListed = nil
        NetworkManager.getUserListened {  [weak self] userListned in
            self?.dataModel.userListenedListModel = userListned
            self?.view?.didLoadListed()
            self?.getVideoFromListed(link: userListned.lesson?.getCurrentDayLink())
        }
    }
    
    func getSectionList() {
        NetworkManager.getSectionList { [weak self] sectionListModel in
            self?.dataModel.sectionListModel = sectionListModel
            self?.view?.didLoadSectionList()
            guard let data = sectionListModel.data else { return }
            for (index,secton) in data.enumerated() {
                let link = secton.paths?.getCurrentDayLink()
                self?.getVideoFromSection(index: index, link: link)
            }
        }
    }
    
    //TODO: - добавить прогрузку для Recomended

    
    //MARK: - BufferVideo
    
    private func getVideoFromSettings(link: String?) {
        getVideo(link: link) { [weak self] url in
            guard let `self` = self else { return }
            self.dataModel.bufferedSettingsVideo = url
            self.view?.didLoadSettingsVideo()
        }
    }
    
    private func getVideoFromListed(link: String?) {
        getVideo(link: link) { [weak self] url in
            guard let `self` = self else { return }
            self.dataModel.bufferedListed = url
            self.view?.didLoadListedVideo()
        }
    }
    
    private func getVideoFromRecomended(index: Int ,link: String?) {
        getVideo(link: link) { [weak self] url in
            guard let `self` = self else { return }
            self.dataModel.bufferedRecomended[index] = url
            self.view?.didLoadRecomendedVideo(index: index)
        }
    }
    
    private func getVideoFromSection(index: Int ,link: String?) {
        getVideo(link: link) { [weak self] url in
            guard let `self` = self else { return }
            self.dataModel.bufferedSection[index] = url
            self.view?.didLoadSectionsVideo(index: index)
        }
    }
    
    private func getVideo(link: String?, success: @escaping (URL)->()) {
        guard let link = link else { return }
        if link == "" { return }
        NetworkManager.getVideo(videoUrl: link) { url in
            success(url)
        }
    }
}
