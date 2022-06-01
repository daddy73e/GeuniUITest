//
//  PagerItemCell.swift
//  GeuniUITest
//
//  Created by Yeongeun Song on 2022/06/01.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class PagerItemCell: UICollectionViewCell {
 
    private let titleLabel = UILabel().then {
        $0.text = "각 셀의 TITLE"
        $0.textColor = .red
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
    
    func setupViews() {
        self.addSubview(titleLabel)
    }
    
    func layout() {
        titleLabel.pin.top().left().margin(20).sizeToFit()
    }
}
