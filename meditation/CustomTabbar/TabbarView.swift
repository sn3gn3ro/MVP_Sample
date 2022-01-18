//
//  TabbarView.swift
//  meditation
//
//  Created by Ilya Medvedev on 18.01.2022.
//

import UIKit

protocol TabbarViewDelegate: AnyObject {
    func itemPressed(item: Int)
}

class TabbarView: UIView {
    
    let stackView = UIStackView()
    var tabViews = [TabView]()
    
    weak var delegate:TabbarViewDelegate?
    
    init(tabItems: [TabItemType], activeIndex: Int) {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
        
        configurateStackView()
        configurateTabViews(tabItems:tabItems, activeIndex: activeIndex)
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
    }
    
    //MARK: - Action
    
    func activeteItem(index: Int) {
        tabViews.forEach {
            $0.setUnactive()
        }
        tabViews[index].setActive()
    }
    
    //MARK: - Private
    
    @objc private func handleTap(_ sender: UIGestureRecognizer) {
        delegate?.itemPressed(item: sender.view!.tag)
    }
    
    private func configurateTabViews(tabItems: [TabItemType], activeIndex: Int) {
        backgroundColor = UIColor.Main.tabbarBackground//.clear
        isUserInteractionEnabled = true
        for i in 0 ..< tabItems.count {
            let itemView = createTabItem(item: tabItems[i], index: i, activeIndex: activeIndex)
            itemView.tag = i
            tabViews.append(itemView)
            stackView.addArrangedSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.snp.makeConstraints { (make) in
                make.height.equalToSuperview()
                make.width.equalTo(UIScreen.main.bounds.width / CGFloat(tabItems.count))
            }
        }
    }
    
    private func configurateStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.distribution = .equalSpacing
    }
    
    private func createTabItem(item: TabItemType,index: Int,activeIndex:Int) -> TabView {
        let tabBarItem = TabView(tabItem: item, isActive: index == activeIndex)
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        
        return tabBarItem
    }
}

