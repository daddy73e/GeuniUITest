//
//  LifeBenefitSolQuizeCell.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/05/31.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class LifeBenefitSolQuizeCell: UICollectionViewCell {
    
    private let container = UIView().then {
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let joinQuizeButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.setTitle("퀴즈참여하기", for: .normal)
    }
    
    private let quizTitleLabel = UILabel().then {
        $0.text = "오늘의 Quiz"
        $0.textAlignment = .center
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.numberOfLines = 1
    }
    
    private let quizContentLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.numberOfLines = 0
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
        return CGSize(width: size.width, height: 340)
    }
    
    func setupViews() {
        contentView.flex.define { flex in
            flex.addItem(container).margin(0)
        }
        
        container.flex.direction(.column).define { flex in
            flex.addItem().grow(1)
            flex.addItem().direction(.column).define { flex in
                flex.addItem(quizTitleLabel).marginBottom(16)
                flex.addItem(quizContentLabel).marginBottom(16)
                flex.addItem(joinQuizeButton).height(40)
            }.marginBottom(20).marginLeft(20).marginRight(20)
        }
    }
    
    func layout() {
        container.pin.all()
        container.flex.layout()
    }
    
    func configure(data: LifeBenefitSolQuiz) {
        quizContentLabel.text = data.solQuiz
        setNeedsLayout()
    }
}
