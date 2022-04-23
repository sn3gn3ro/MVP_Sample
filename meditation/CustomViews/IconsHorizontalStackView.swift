//
//  IconsHorizontalStackView.swift
//  meditation
//
//  Created by Ilya Medvedev on 28.01.2022.
//

import UIKit

class IconsHorizontalStackView: UIView {

    var icons = [URL]()
    var imageViews = [UIImageView]()
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
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
    }
    
    func setData(icons:[URL]) {
        imageViews.forEach{$0.removeFromSuperview()}
        configureStack(icons: icons)
    }
    
    //MARK: - Private
    

    private func configureStack(icons:[URL]) {
        for (index,icon) in icons.enumerated() {
            if index > 2 {
                break
            }
            let imageView = UIImageView()
            imageView.image = UIImage(named: "userPhotoTest")
//            imageView.kf.setImage(with: icon, options: [.processor(SVGImgProcessor())])
            addSubview(imageView)
            imageViews.append(imageView)
            imageView.snp.makeConstraints { (make) in
                make.height.width.equalTo(40)
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(25 * index)
                if index == icons.count - 1 {
                    make.right.equalToSuperview()
                }
            }
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 20
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.Main.primaryViolet.cgColor
            imageView.layer.masksToBounds = true
            imageView.clipsToBounds = true
        }
    }
}


