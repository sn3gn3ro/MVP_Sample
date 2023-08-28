//
//  FavoritesPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 22.01.2022.
//

import Foundation

protocol FavoritesProtocol: AnyObject {
    func didLoadData()
    func didLoadVideo(index: Int)
}

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesProtocol, dataModel: FavoritesDataModel)
    func getData()
    
    func getVideoForLesson(index: Int)
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    weak private var view: FavoritesProtocol?
    var dataModel: FavoritesDataModel
    
    required init(view: FavoritesProtocol, dataModel: FavoritesDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func getData() {
        NetworkManager.getFavoriteList { [weak self] favoriteModel in
            self?.dataModel.favoriteModel = favoriteModel
            self?.view?.didLoadData()
            
            for (index,_) in favoriteModel.enumerated() {
                self?.getVideoForLesson(index: index)
            }
        }
    }
    
    func getVideoForLesson(index: Int) {
        guard let favorites = dataModel.favoriteModel else { return }
        let videoUrl = favorites[index].lesson?.getCurrentDayLink() ?? ""
        NetworkManager.getVideo(videoUrl: videoUrl) { [weak self] url in
            self?.dataModel.bufferedVideos[index] = url
            self?.view?.didLoadVideo(index: index)
        }
    }
}

