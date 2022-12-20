//
//  UnderlineSegmentCell.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/22.
//

import UIKit

protocol UnderlineSegmentCellDelegate: AnyObject {
    func selectCell(item: UnderlineSegmentItem)
    func animateCell(frame: CGRect)
}

final class UnderlineSegmentCell: UICollectionViewCell {
    
    public weak var delegate: UnderlineSegmentCellDelegate?
    private var cellState: UnderlineSegmentItem?
    
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
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func configureUI() {
        self.contentView.addSubview(container)
        self.container.addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureLayout() {
        self.container.translatesAutoresizingMaskIntoConstraints = false
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            self.container.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.button.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 0),
            self.button.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 0),
            self.button.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: 0),
            self.button.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: 0),
        ]
        
        constraints.forEach {
            $0.isActive = true
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(item: UnderlineSegmentItem) {
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
