//
//  CustomScrollView.swift
//  meditation
//
//  Created by Ilya Medvedev on 12.01.2022.
//

import UIKit

protocol CustomScrollViewDelegate: AnyObject {
    func didScrollToNextPage(page: CGFloat)
    func didScrollToPreviousPage(page: CGFloat)
}

class CustomScrollView: UIView {
    
    var scrollView = UIScrollView()
        
    var views = [UIView]()
    
//    var screenChangedToNext:((_ screen: CGFloat)->())?
//    var screenChangedToPrevious:((_ screen: CGFloat)->())?
    weak var delegate: CustomScrollViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        clipsToBounds = true        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview else { return }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configurateScrollView()
    }
    
    func setViews(views: [UIView]) {
        self.views = views
    }
    
    // MARK: - Actions

    func scrollToNextScreen() {
        let offsetX = scrollView.contentOffset.x
        let page = (offsetX + (scrollView.frame.size.width)) / scrollView.frame.size.width
        if page < CGFloat(views.count) {
            delegate?.didScrollToNextPage(page: page + 1)
            scrollView.setContentOffset(CGPoint(x: offsetX + scrollView.frame.size.width, y: 0), animated: true)
        }
    }
    
    func scrollToPreviousScreen() {
        let offsetX = scrollView.contentOffset.x
        let page = (offsetX - (scrollView.frame.size.width)) / scrollView.frame.size.width
        if page >= 0 {
            delegate?.didScrollToPreviousPage(page: page + 1)
            scrollView.setContentOffset(CGPoint(x: offsetX - scrollView.frame.size.width, y: 0), animated: true)
        }
    }
    
    func scrollToScreen(screenNumber: Int) {
        let width = scrollView.frame.size.width * CGFloat(screenNumber)
        scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: true)
    }
    
    // MARK: - Private
    
    private func configurateScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        for (index, view) in views.enumerated() {
            view.frame = CGRect(x: self.bounds.width * CGFloat(index), y: 0, width: self.bounds.width, height: self.bounds.height)
            scrollView.addSubview(view)
        }
        
        scrollView.contentSize = CGSize(width: self.bounds.width * CGFloat(views.count), height: self.bounds.height)
        scrollView.isPagingEnabled                  = true
        scrollView.bounces                          = false
        scrollView.showsVerticalScrollIndicator     = false
        scrollView.showsHorizontalScrollIndicator   = false
        scrollView.delegate                         = self
        
        scrollView.isScrollEnabled = false
    }
    
}

extension CustomScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}
