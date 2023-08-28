//
//  MainViewController + CellDelegate.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.08.2023.
//

import UIKit

// MARK: - MainPictureTableCellDelegate

//extension MainViewController : MainPictureTableCellDelegate {
//    func didLoadSettingsVideo(videoURL: URL) {
//        presenter.dataModel.bufferedSettingsVideo = videoURL
//    }
//}

// MARK: - MainSearchTableCellDelegate

extension MainViewController : MainSearchTableCellDelegate {
    func searchButtonPressed() {
        ModuleRouter.showSearchModule(currentViewController: self)
//        sections = [.picture,
//                    .search,
//                    .searchHashtags,
//                    .played,
//                    .recomendedHeader,
//                    .recomended,
//                    .podcastsHeader,
//                    .podcasts]
//        tableView.reloadData()
    }
}

// MARK: - MainPlayedTableCellDelegate

extension MainViewController : MainPlayedTableCellDelegate {
    
    func playButtonPressed() {
        
    }
}

// MARK: - MainRecomendedTableCellDelegate

extension MainViewController : MainRecomendedTableCellDelegate {
    
    func didSelectPodcast(index: Int) {
//        NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
//        ModuleRouter.showPlayerModule(currentViewController: self,
//                                      lessonId: 1,
//                                      lessons: presenter.dataModel.sectionListModel?.data?[index].lessons ?? [],
//                                      lessonBufferedVideo: nil,
//                                      sectionName: presenter.dataModel.sectionListModel?.data?[index].name,
//                                      idUnfinishedLessons: nil)
    }
}

// MARK: - MainPodcastsHeaderTableCellDelegate

extension MainViewController : MainPodcastsHeaderTableCellDelegate {
    func moreButtonPressed() {
        
    }
}

