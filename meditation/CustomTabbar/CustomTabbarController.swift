//
//  CustomTabbarController.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import UIKit

enum TabbarSettings {
    static var height: CGFloat {
       return 100
    }
}

class CustomTabbarController: UITabBarController {
    
    var customTabBar: TabbarView?
    
    let tabItems: [TabItemType]
    
//    private var teamsModels = [DepartmentApiModel]()
//    private var department: DepartmentApiModel?
    
    init() {
        tabItems = [.main, .profile]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadTabBar()
    }
    
    
    func visibility(isHidden: Bool) {
        customTabBar?.isHidden = isHidden
    }
    
    private func loadTabBar() {
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
    }

    private func setupCustomTabBar(_ items: [TabItemType], completion: @escaping ([UIViewController]) -> Void){
        var controllers = [UIViewController]()
        tabBar.isHidden = true
        customTabBar = TabbarView(tabItems: items, activeIndex: 0)
        customTabBar!.translatesAutoresizingMaskIntoConstraints = false
        customTabBar!.clipsToBounds = true
        customTabBar?.delegate = self
        view.addSubview(customTabBar!)
        
        customTabBar?.snp.makeConstraints({ (make) in
            make.left.equalTo(tabBar)
            make.right.equalTo(tabBar)
            make.bottom.equalTo(tabBar)
            make.height.equalTo(TabbarSettings.height)
            make.width.equalTo(tabBar)
        })

        for i in 0 ..< items.count {
            let navigationController = UINavigationController(rootViewController: items[i].viewController)
            navigationController.navigationBar.isHidden = true
            
            controllers.append(navigationController)
        }

        self.view.layoutIfNeeded()
        completion(controllers)
    }
    
   private func changeTab(tab: Int) {
        self.selectedIndex = tab
        customTabBar?.activeteItem(index: tab)
    }
}

extension CustomTabbarController: TabbarViewDelegate {
    func itemPressed(item: Int) {
        changeTab(tab: item)
    }
}

