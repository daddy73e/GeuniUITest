//
//  HeaderView.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/06/28.
//

import FlexLayout
import PinLayout
import Then
import UIKit

class HeaderView: UICollectionReusableView {
    
    private let titleLabel = UILabel().then {
        $0.text = "헤더"
        $0.textColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func configure() {
        self.addSubview(titleLabel)
    }
    
    private func layout() {
        titleLabel.pin.all()
    }
    
}
