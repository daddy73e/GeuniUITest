//
//  LifeBenefitEventCell.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/05/31.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class LifeBenefitEventCell: UICollectionViewCell {

    private let container = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "이벤트"
        $0.font = UIFont.systemFont(ofSize: 14)
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
        return CGSize(width: size.width, height: 220)
    }
    
    func setupViews() {
        contentView.flex.define { flex in
            flex.addItem(container).margin(0)
        }
        
        container.flex.direction(.row).define { flex in
            
        }
    }
    
    func layout() {
        container.pin.all()
        container.flex.layout()
    }
    
    func configure(data: LifeBenefitEvent) {
        setNeedsLayout()
    }
}
