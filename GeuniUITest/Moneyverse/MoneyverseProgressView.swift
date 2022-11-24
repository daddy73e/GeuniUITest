//
//  MoneyverseProgressView.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/09/06.
//

import UIKit
import FlexLayout
import PinLayout
import Then

final class MoneyverseProgressView: UIView {
    
    private var progress: CGFloat = 0.5
    
    private let rootContainer = UIView().then {
        $0.backgroundColor = .red
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 8
    }
    
    private let foregroundView = UIView().then {
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 8
    }
    
    private let cursor = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    public init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    public init(progress: CGFloat) {
        super.init(frame: .zero)
        self.progress = progress
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    private func configureUI() {
        self.backgroundColor = .clear
        self.addSubview(rootContainer)
        self.addSubview(backgroundView)
        self.addSubview(foregroundView)
        self.addSubview(cursor)
        
    }
    
    private func configureLayout() {
        
        rootContainer.pin.all()
        backgroundView.pin.bottom()
            .horizontally()
            .marginHorizontal(20)
            .height(24)
        let leftMargin = 20.0
        let entire:CGFloat = self.bounds.width - (leftMargin * 2)
        let progress = entire * progress
        foregroundView.pin.bottom()
            .left()
            .marginLeft(leftMargin)
            .height(24)
            .width(progress)
        
        let cursorSize = CGSize(width: 42, height: 40)
        let cursorMarginLeft = leftMargin + progress - (cursorSize.width * 0.5)
        cursor.pin.above(of: foregroundView)
            .left()
            .marginBottom(4)
            .size(cursorSize)
            .marginLeft(cursorMarginLeft)
        foregroundView.applyGradient(colours: [
            UIColor(hex: "#6DADF4"),
            UIColor(hex: "#368DED")
        ])
    }
}

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
        gradient.endPoint = CGPoint(x :1.0, y: 0.5)
        gradient.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
}


public extension UIColor {
    convenience init(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                if hexColor.count == 8 {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                } else if hexColor.count == 6 {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    
                    
                    self.init(red: r, green: g, blue: b, alpha: CGFloat(1.0))
                    return
                }
            }
        }
        
        self.init(red: 0.071, green: 0.086, blue: 0.098, alpha: 1)
        return
    }
}
