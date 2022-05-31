//
//  LifeBenefitFortuneCell.swift
//  YGUITest
//
//  Created by Yeongeun Song on 2022/05/30.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class LifeBenefitFortuneCell: UICollectionViewCell {
    
    private let container = UIView().then {
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }
    
    private let image = UIImageView().then {
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let contentLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "logo"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        return CGSize(width: size.width, height: 64)
    }
    
    func setupViews() {
        contentView.flex.define { flex in
            flex.addItem(container).margin(0)
        }
        
        container.flex.direction(.row).define { flex in
            flex.addItem(image).marginVertical(10).marginLeft(10).width(44).backgroundColor(.red)
            flex.addItem().marginVertical(12).marginLeft(12).marginRight(20)
                .grow(1)
                .justifyContent(.center)
                .define { flex in
                    flex.addItem(titleLabel)
                    flex.addItem(contentLabel)
                }
        }
        
        contentView.addSubview(closeButton)
    }
    
    func layout() {
        container.pin.all()
        closeButton.pin.top(8).right(8).width(24).height(24)
        container.flex.layout()
    }
    
    func configure(data: LifeBenefitFortune) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        setNeedsLayout()
    }
}
