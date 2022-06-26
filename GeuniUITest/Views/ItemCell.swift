//
//  ItemCell.swift
//  GeuniUITest
//
//  Created by Yeongeun Song on 2022/06/24.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class ItemCell: UICollectionViewCell {
    
    private let container = UIView().then {
        $0.backgroundColor = .green
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let label = UILabel().then {
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureLayout()
    }
    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        configureLayout()
//        container.flex.layout(mode: .adjustHeight)
//        return CGSize(width: size.width, height: container.bounds.height)
//    }
    
    public func configure(itemValue:String) {
        self.label.text = itemValue
    }
}

extension ItemCell {
    func configureUI() {
        contentView.flex.define { flex in
            flex.addItem(container).margin(0).height(50)
        }
        
        container.flex.direction(.row).define { flex in
            flex.addItem(label).height(40).marginHorizontal(0)
        }
    }
    
    func configureLayout() {
        container.pin.all()
        container.flex.layout()
    }
}
