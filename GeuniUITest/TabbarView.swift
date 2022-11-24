//
//  UnderlineSegemntView.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/22.
//

import UIKit
import FlexLayout
import PinLayout
import Then

protocol UnderlineSegemntViewDelegate: AnyObject {
    func selectedTabItem(item: TabItem, updateTabItems: [TabItem])
}

final class UnderlineSegemntView: UIView {
    
    public weak var delegate: UnderlineSegemntViewDelegate?
    
    private let container = UIView()
    private var underLine = UIView()
    private var tabItems = [TabItem]()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    ).then { [weak self] in
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.contentInset = self?.padding ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.register(TabItemViewCell.self, forCellWithReuseIdentifier: TabItemViewCell.identifier)
    }
    
    private let normalFont: UIFont
    private let selectedFont: UIFont
    private let normalTitleColor: UIColor
    private let selectedTitleColor: UIColor
    private let underLineColor: UIColor
    private let underLineHeight: CGFloat
    private let spacing: CGFloat
    private let padding: UIEdgeInsets
    private var selectedIndex: Int?
    
    init(
        normalFont: UIFont = .systemFont(ofSize: 25),
        selectedFont: UIFont = .systemFont(ofSize: 25, weight: .bold),
        normalTitleColor: UIColor = .black,
        selectedTitleColor: UIColor = .black,
        underLineColor: UIColor = .black,
        underLineHeight: CGFloat = 2.0,
        spacing: CGFloat = 0.0,
        padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    ) {
        self.normalFont = normalFont
        self.selectedFont = selectedFont
        self.normalTitleColor = normalTitleColor
        self.selectedTitleColor = selectedTitleColor
        self.underLineColor = underLineColor
        self.underLineHeight = underLineHeight
        self.spacing = spacing
        self.padding = padding
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        let spacing = CGFloat(self.spacing)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(10),
            heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: itemSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = .zero
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureLayout()
    }
    
    func configureUI() {
        self.addSubview(self.container)
        self.container.flex.define { flex in
            flex.addItem(collectionView)
                .marginHorizontal(0)
                .height(50)
        }
        
        self.collectionView.addSubview(underLine)
        self.underLine.backgroundColor = underLineColor
        self.underLine.isHidden = true
    }
    
    func configureLayout() {
        self.container.pin.all(self.pin.safeArea)
        self.container.flex.layout()
        self.collectionView.pin.all()
    }
    
    func configureView(values: [TabItem], selectedIndex: Int? = 0) {
        guard let selectedIndex = selectedIndex else {
            refreshTabBar(values: values)
            self.selectedIndex = 0
            return
        }
        
        if values.count <= selectedIndex {
            refreshTabBar(values: values)
            return
        }
        var updateValues = values
        for index in 0..<updateValues.count {
            updateValues[index].selected = index == selectedIndex
        }
        self.selectedIndex = selectedIndex
        refreshTabBar(values: updateValues)
    }
    
    func resetUnderline() {
        guard let selectedIndex = selectedIndex else {
            self.updateUnderline(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 0,
                    height: self.underLineHeight
                ),
                animated: false
            )
            
            return
        }
        
        if let cell = self.collectionView.cellForItem(
            at: IndexPath(
                row: selectedIndex,
                section: 0
            )
        ) {
            if let globalFrame = cell.globalFrame(window: cell.window) {
                self.updateUnderline(
                    frame: CGRect(
                        x: globalFrame.origin.x,
                        y: 0,
                        width: globalFrame.width,
                        height: self.underLineHeight
                    ),
                    animated: false
                )
            }
            
        }
    }
    
    func refreshTabBar(values: [TabItem]) {
        tabItems = values
        configureLayout()
        self.collectionView.reloadData()
    }
    
    func updateUnderline(frame: CGRect, animated: Bool) {
        self.underLine.isHidden = false
        DispatchQueue.main.async {
            if !animated {
                self.underLine.frame = CGRect(
                    x: frame.origin.x + self.collectionView.contentOffset.x,
                    y: self.collectionView.frame.height - self.underLineHeight,
                    width: frame.size.width,
                    height: self.underLineHeight
                )
            } else {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0 ,
                    options: .curveEaseInOut
                ) { [weak self] in
                    self?.underLine.frame = CGRect(
                        x: frame.origin.x + (self?.collectionView.contentOffset.x ?? 0.0),
                        y: (self?.collectionView.frame.height ?? 0.0) - (self?.underLineHeight ?? 0.0),
                        width: frame.size.width,
                        height: self?.underLineHeight ?? 0.0
                    )
                    self?.underLine.layoutIfNeeded()
                } completion: { isFinish in
                    
                }
            }
        }
    }
}

extension UnderlineSegemntView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TabItemViewCell.identifier,
            for: indexPath
        ) as? TabItemViewCell {
            cell.delegate = self
            cell.normalFont = normalFont
            cell.selectedFont = selectedFont
            cell.normalTitleColor = normalTitleColor
            cell.selectedTitleColor = selectedTitleColor
            cell.configure(item: self.tabItems[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension UnderlineSegemntView: TabItemViewCellDelegate {
    func selectCell(item: TabItem) {
        for (index, each) in tabItems.enumerated() {
            tabItems[index].selected = each.key == item.key
        }
        
        self.delegate?.selectedTabItem(item: item, updateTabItems: tabItems)
    }
    
    func animateCell(frame: CGRect) {
        self.updateUnderline(frame: frame, animated: true)
    }
}


