//
//  TabView.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import UIKit

enum TabItemType {
    case main
    case profile
    
    func image(isActive: Bool) -> UIImage {
        switch self {
            case .main:
                return  isActive ? UIImage(named: "tabbarMainOn") ?? UIImage() : UIImage(named: "tabbarMainOff") ?? UIImage()
            case .profile:
                return  isActive ?  UIImage(named: "tabbarProfileOn") ?? UIImage() : UIImage(named: "tabbarProfileOff") ?? UIImage()
        }
    }
    
    func activeColor() -> UIColor {
        return UIColor.white
    }

    func unactiveColor() -> UIColor {
        return UIColor.Main.tabbarUnactive
    }
    
    var viewController: UIViewController {
        switch self {
        case .main:
            let navigationController = UINavigationController(rootViewController: ModuleBuilder.createMainModule())
            navigationController.navigationBar.isHidden = true

            return ModuleBuilder.createMainModule()
        case .profile:
            let navigationController = UINavigationController(rootViewController: ModuleBuilder.createProfileModule())
            navigationController.navigationBar.isHidden = true

            return ModuleBuilder.createProfileModule()
        }
    }
    
    func name() -> String {
        switch self {
        case .main:
            return CommonString.main
        case .profile:
            return CommonString.profile
        }
    }
}

class TabView : UIView {
    
    var tabImageView = UIImageView()
    var tabLabel = UILabel()
    
    var tabItem: TabItemType
        
    init(tabItem: TabItemType, isActive: Bool) {
        self.tabItem = tabItem
        super.init(frame: CGRect.zero)

        tabImageView.image = tabItem.image(isActive: isActive)
        tabLabel.text = tabItem.name()
        tabLabel.textColor = isActive ? tabItem.activeColor() : tabItem.unactiveColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }
        
        configurateSelf()
        configurateTabImageView()
        configurateTabLabel()
    }
    
    //MARK: - Actions
    
    func setActive() {
//        self.backgroundColor = TabItemType.home.activeColor()
        tabImageView.image = tabItem.image(isActive: true)
        tabLabel.textColor = tabItem.activeColor()
    }
    
    func setUnactive() {
//        self.backgroundColor = TabItemType.home.unactiveColor()
        tabImageView.image = tabItem.image(isActive: false)
        tabLabel.textColor = tabItem.unactiveColor()
    }
    
    //MARK: - Private
    
    private func configurateSelf() {
//        self.layer.cornerRadius = 14
    }
    
    private func configurateTabImageView() {
        addSubview(tabImageView)
        tabImageView.snp.makeConstraints { (make) in
            make.height.equalTo(36)
            make.width.equalTo(36)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
    }
    
    private func configurateTabLabel() {
        addSubview(tabLabel)
        tabLabel.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(tabImageView.snp.bottom)
        }
        tabLabel.textAlignment = .center
        tabLabel.font = UIFont.Basic.latoNormal(size: 12)
//        tabLabel.textColor = .white
        tabLabel.numberOfLines = 0
    }
}

