//
//  CategoryPresenter.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.01.2022.
//

import Foundation

protocol CategoryProtocol: AnyObject {
    func didloadSection()
    func didLoadHeadVideo()
    func didLoadSectionsVideo(index: Int)
}

protocol CategoryPresenterProtocol: AnyObject {
    init(view: CategoryProtocol, dataModel: CategoryDataModel)
    
    func getSection()
    func getSectionHeadVideo()
}

class CategoryPresenter: CategoryPresenterProtocol {
    weak private var view: CategoryProtocol?
    var dataModel: CategoryDataModel
    
    required init(view: CategoryProtocol, dataModel: CategoryDataModel) {
        self.view = view
        self.dataModel = dataModel
    }
    
    
    func getSection() {
        NetworkManager.getSection(id: dataModel.dataModel?.id ?? -1) { [weak self] section in
            self?.dataModel.section = section
            self?.view?.didloadSection()
            guard let lessons =  section.lessons else { return }
            for (index,lesson) in lessons.enumerated() {
                self?.getVideoFromSection(index: index, link: lesson.getCurrentDayLink())
            }
        }
    }
    
    func getSectionHeadVideo() {
        if !dataModel.sectonVideoURL.isBuffered {
            getVideo(link: dataModel.sectonVideoURL.link) { [weak self] url in
                self?.dataModel.sectonVideoURL.link = url.absoluteString
                self?.view?.didLoadHeadVideo()
            }
        }
    }
    
    private func getVideoFromSection(index: Int ,link: String?) {
        getVideo(link: link) { [weak self] url in
            guard let `self` = self else { return }
            self.dataModel.bufferedLessonVideos[index] = url
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
