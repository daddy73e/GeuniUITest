//
//  TabItemViewCell.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/22.
//

import UIKit
import FlexLayout
import PinLayout
import Then

public struct TabItem {
    public let key: Int
    public let value: String
    public var selected = false
    public var underLineHeight = 0.0
    
    init(
        key: Int,
        value: String,
        selected: Bool = false,
        underLineHeight: CGFloat = 0.0
    ) {
        self.key = key
        self.value = value
        self.selected = selected
        self.underLineHeight = underLineHeight
    }
}

protocol TabItemViewCellDelegate: AnyObject {
    func selectCell(item: TabItem)
    func animateCell(frame: CGRect)
}

final class TabItemViewCell: UICollectionViewCell {
    
    public weak var delegate: TabItemViewCellDelegate?
    private var cellState: TabItem?
    
    public var normalFont: UIFont?
    public var selectedFont: UIFont?
    public var normalTitleColor: UIColor?
    public var selectedTitleColor: UIColor?
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    public lazy var button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        $0.titleLabel?.minimumScaleFactor = 0.01
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
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
        contentView.flex.layout(mode: .adjustWidth)
        return contentView.frame.size
    }
    
    func configureUI() {
        contentView.flex.define { flex in
            flex.addItem(container).grow(1)
        }
        
        container.flex.direction(.column).define { flex in
            flex.addItem(button).marginTop(4).marginHorizontal(0).marginBottom(0)
        }
    }
    
    func configureLayout() {
        container.pin.all()
        container.flex.layout()
    }
    
    func configure(item: TabItem) {
        cellState = item
        button.setTitle(item.value, for: .normal)
        button.flex.markDirty()

        if item.selected {
            self.isSelected = true
            button.titleLabel?.font = selectedFont
            button.setTitleColor(selectedTitleColor, for: .normal)
            self.setNeedsLayout()
            animateUnderline(button: button)
        } else {
            self.isSelected = false
            button.setTitleColor(normalTitleColor, for: .normal)
            button.titleLabel?.font = normalFont
            self.setNeedsLayout()
        }
    }
 
    func animateUnderline(button: UIButton) {
        DispatchQueue.main.async {
            guard let globalFrame = button.globalFrame(window: button.window) else {
                return
            }
            
            self.delegate?.animateCell(frame: globalFrame)
        }
    }
    
    @objc func didTapButton() {
        if let cellState = cellState {
            delegate?.selectCell(item: cellState)
        }
    }
}

extension UIView {
    func globalFrame(window: UIWindow?) -> CGRect? {
        return self.superview?.convert(self.frame, to: window)
    }
}
