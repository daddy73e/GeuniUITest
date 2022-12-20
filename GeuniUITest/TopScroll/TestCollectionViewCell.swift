//
//  TestCollectionViewCell.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/25.
//

import UIKit
import FlexLayout
import PinLayout

final class TestCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    private let container = UIView().then {
        $0.backgroundColor = .clear
        $0.accessibilityTraits = .button
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
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        configureLayout()
        contentView.flex.layout(mode: .adjustHeight)
        return contentView.frame.size
    }
    
    func configureUI() {
        contentView.flex.define { flex in
            flex.addItem(container).margin(0)
        }
        
        container.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(titleLabel).justifyContent(.center).marginTop(4).marginHorizontal(0)
        }
    }
    
    func configureLayout() {
        container.pin.all()
        container.flex.layout()
    }
    
    func configure(text: String) {
        titleLabel.text = text
        titleLabel.flex.markDirty()
        self.setNeedsLayout()
    }
}
