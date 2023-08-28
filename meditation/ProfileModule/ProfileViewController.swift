//
//  ProfileViewController.swift
//  meditation
//
//  Created by Ilya Medvedev on 21.01.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let tableView = UITableView()
    let imagePicker = UIImagePickerController()
    var presenter: ProfilePresenter!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Main.primaryViolet
        self.hideKeyboardWhenTappedAround()
        setTableView()
        
//        presenter.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        presenter.dataModel.isDataLoad = false
//        tableView.reloadData()
        presenter.getData()
        
        NotificationCenter.default.post(name: Notification.Name("showTabbar"), object: nil, userInfo: nil)
    }

    // MARK: - Private
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TabbarSettings.height)
        }
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
    
        tableView.register(ProfileMainTableCell.self, forCellReuseIdentifier: "ProfileMainTableCell")
        tableView.register(ProfileSettingTableCell.self, forCellReuseIdentifier: "ProfileSettingTableCell")
        tableView.register(ProfileExitTableCell.self, forCellReuseIdentifier: "ProfileExitTableCell")
    }
    
    private func showImagePickerAlert() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            [weak self] UIAlertAction in
            self?.showImagePickerView(type: .camera)
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            [weak self] UIAlertAction in
            self?.showImagePickerView(type: .savedPhotosAlbum)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){
            [weak self] UIAlertAction in
            self?.presenter.deleteAvatar()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func showImagePickerView(type: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(type){
            print("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = type
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = presenter.dataModel.sections[indexPath.section]
        switch section {
            case .settings(let types):
                settingsAction(type: types[indexPath.row])
            case .exit:
           break
            default:
                break
        }
    }
    
    func settingsAction(type: ProfileSettingTableCell.Setting) {
        switch type {
            case .favoritesLessons:
                NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
                ModuleRouter.showFavoritesModule(currentViewController: self)
            case .subscription:
                   NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
                   ModuleRouter.showSubscriptionModule(currentViewController: self)
            case .notifications:
                NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
                ModuleRouter.showNotificationsSettingsModule(currentViewController: self)
            case .review:
                print("")
        }
       
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.dataModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter.dataModel.sections[section] {
            case .main:
                return 1
            case .settings(let types):
                return types.count
            case .exit:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.dataModel.sections[indexPath.section] {
            case .main:
                return profileMainTableCell(indexPath: indexPath, image: UIImage(named: "backTest") ?? UIImage())
            case .settings(let types):
                let type = types[indexPath.row]
                return profileSettingTableCell(indexPath: indexPath, type: type)
            case .exit:
                return profileExitTableCell(indexPath: indexPath)
        }
    }
    
    
    private func profileMainTableCell(indexPath: IndexPath, image: UIImage) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMainTableCell", for: indexPath) as! ProfileMainTableCell
        cell.delegate = self
        if let userInfo =  presenter.dataModel.userInfo {
            cell.setData(backImage: UIImage(named: "backNightTest") ?? UIImage(),
                         profileImage: presenter.dataModel.userAvatar,
                         email: userInfo.email ?? "",
                         name: userInfo.name ?? "")
        } else {
            cell.setSkeleton()
        }
        return cell
    }
    
    private func profileSettingTableCell(indexPath: IndexPath, type: ProfileSettingTableCell.Setting) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSettingTableCell", for: indexPath) as! ProfileSettingTableCell
        if let _ =  presenter.dataModel.userInfo {
            cell.setData(type: type)
        } else {
            cell.setSkeleton()
        }
        
        return cell
    }
    
    private func profileExitTableCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileExitTableCell", for: indexPath) as! ProfileExitTableCell
        cell.delegate = self
        if let _ =  presenter.dataModel.userInfo {
            cell.setData()
        } else {
            cell.setSkeleton()
        }
        
        return cell
    }  
}

// MARK: - ProfileMainTableCellDelegate

extension ProfileViewController : ProfileMainTableCellDelegate {
    func favoritesPressed() {
        
    }
    
    func profileImagePressed() {
        showImagePickerAlert()
    }
    
    func editPressed() {
        NotificationCenter.default.post(name: Notification.Name("hideTabbar"), object: nil, userInfo: nil)
        ModuleRouter.showProfileEditModule(currentViewController: self)
    }
}

// MARK: - ProfileExitTableCellDelegate

extension ProfileViewController: ProfileExitTableCellDelegate {
    func exitButtonPressed() {
        guard let window = UIApplication.shared.windows.first else { return }
        UserDefaultsManager.clearToken()
        UserDefaultsManager.clearUserInfo()
        ModuleRouter.setRootSignUpModule(window: window)
    }
}


// MARK: - UIImagePickerControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[.originalImage] as? UIImage {
            presenter.dataModel.userAvatar = image
            presenter.uploadAvatarImage()
            tableView.reloadData()
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - ProfileProtocol

extension ProfileViewController : ProfileProtocol {
    func dataLoad() {
        tableView.reloadData()
//        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .none)
    }
    
    
}
