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
    
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    private let container = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: makeLayout()).then {
        
        $0.backgroundColor = .systemBackground
        $0.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "이벤트"
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.setupDataSource()
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
        return CGSize(width: size.width, height: 220)
    }
    
    
    func setupDataSource() {
        self.dataSource =
        UICollectionViewDiffableDataSource<Int, String>(collectionView: self.collectionView) {
            (collectionView, indexPath, itemValue) -> UICollectionViewCell? in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell {
                cell.configure(itemValue: itemValue)
                return cell
            }
            
            return UICollectionViewCell()
        }
    }
    
    func configure(data: LifeBenefitEvent) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(data.arrTest)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let columns = 1
            let spacing = CGFloat(10)
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .estimated(30))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                           subitem: item,
                                                           count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 20, bottom: 45, trailing: 20)
            
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        return layout
    }
}

extension LifeBenefitEventCell {
    func configureUI() {
        contentView.flex.define { flex in
            flex.addItem(container).margin(0)
        }
        
        container.flex.direction(.row).define { flex in
            flex.addItem(collectionView).grow(1)
        }
    }
    
    func configureLayout() {
        container.pin.all()
        container.flex.layout()
    }
}
