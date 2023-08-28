//
//  PlayerPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 26.01.2022.
//

import Foundation

protocol PlayerProtocol: AnyObject {
    func didGetLesson()
    func didLoadVideo(url: URL)
    func didLoadAudio(data: Data)
    func didChangeIsFavoriteState(isFavorite: Bool)
    func didListedAllLessons()
}

protocol PlayerPresenterProtocol: AnyObject {
    init(view: PlayerProtocol, dataModel: PlayerDataModel)
    
    func changeFavoriteState()
    func getLessonInfo()
    func setListenedLesson(durationSeconds: Int,isFinishLesson: Int?)
    
}

class PlayerPresenter: PlayerPresenterProtocol {
    weak private var view: PlayerProtocol?
    var dataModel: PlayerDataModel
    
    required init(view: PlayerProtocol, dataModel: PlayerDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    func setListenedLesson(durationSeconds: Int, isFinishLesson: Int?) {
        guard let lesson = dataModel.lesson else { return }
        if !(lesson.listened ?? true) {
            NetworkManager.userListenedCreate(lessonId: lesson.id ?? -1,
                                              durationSeconds: durationSeconds,
                                              isFinishLesson: isFinishLesson) {
                
            }
        }
        
        if isFinishLesson == 1 {
            dataModel.idUnfinishedLessons[dataModel.lessonId] = true
            lessonsListedCheck()
        }
    }
    
    private func lessonsListedCheck() {
        if  dataModel.idUnfinishedLessons.first(where: {$0.value == false}) == nil {
            view?.didListedAllLessons()
        }
    }
    
    func changeFavoriteState() {
        guard let lesson = dataModel.lesson else { return }
        guard let lessonId = lesson.id else { return }
        if lesson.favorite ?? false {
            NetworkManager.deleteFavoriteList(lessonId: lessonId) {
                
            }
        } else {
            NetworkManager.createFavoriteList(lessonId: lessonId) {
                
            }
        }
        
        let state = dataModel.lesson?.favorite ?? false
        dataModel.lesson?.favorite = !state
        view?.didChangeIsFavoriteState(isFavorite:  dataModel.lesson?.favorite ?? false)
       
//        NetworkManager.getFavoriteList { list in
//
//        }
    }
    
    func getLessonInfo() {
        NetworkManager.getLesson(id: dataModel.lessonId) { [weak self] lesson in
            guard let `self` = self else { return }
            self.dataModel.lesson = lesson
            self.view?.didGetLesson()
            lazy var link = ""
            switch DayTime.getDayTime() {
            case .morning:
                link = self.dataModel.lesson?.paths?.fileAnimationMorning?.link ?? ""
            case .day:
                link = self.dataModel.lesson?.paths?.fileAnimationDay?.link ?? ""
            case .evening:
                link = self.dataModel.lesson?.paths?.fileAnimationEvening?.link ?? ""
            case .night:
                link = self.dataModel.lesson?.paths?.fileAnimationNight?.link ?? ""
            }
            if let currentBufferedVideo = self.getCurrentBufferedVideo() {
                self.view?.didLoadVideo(url: currentBufferedVideo)
            } else {
                self.getVideo(link: link, indexOfCurrentLesson: self.dataModel.indexOfCurrentLesson())
            }
            self.getAudio(link: self.dataModel.lesson?.paths?.fileAudio?.link ?? "")
        }
    }
    
    func getCurrentBufferedVideo() -> URL? {
        if dataModel.lessonBufferedVideo.count - 1 >= dataModel.indexOfCurrentLesson() {
            return dataModel.lessonBufferedVideo[dataModel.indexOfCurrentLesson()]
        } else {
            return nil
        }
    }
    
    private func getVideo(link: String, indexOfCurrentLesson: Int) {
        NetworkManager.getVideo(videoUrl: link) { [weak self] url in
            guard let `self` = self else { return }
            self.view?.didLoadVideo(url: url)
            self.dataModel.lessonBufferedVideo[indexOfCurrentLesson] = url
        }
    }
    
    private func getAudio(link: String) {
        NetworkManager.getAudio(url: link) { [weak self] data in
            self?.view?.didLoadAudio(data: data)
        }
        
    }
}

