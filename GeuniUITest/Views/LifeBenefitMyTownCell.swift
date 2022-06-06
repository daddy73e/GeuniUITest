//
//  LifeBenefitMyTownCell.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/06/02.
//

import UIKit
import FlexLayout
import PinLayout
import Then
import Entity

class LifeBenefitMyTownCell: UICollectionViewCell {
    
    var dataSource: UICollectionViewDiffableDataSource<Int, LifeBenefitMyTown>!
    
    private let container = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "우리동네 혜택"
        $0.textColor = .black
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: createLayout()).then {
        $0.backgroundColor = .clear
        $0.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        $0.register(LifeBenefitMytownItemCell.self, forCellWithReuseIdentifier: "LifeBenefitMytownItemCell")
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
        return CGSize(width: size.width, height: 188)
    }
    
    func setupViews() {
        contentView.flex.define { flex in
            flex.addItem(container).margin(0)
        }
        
        container.flex.direction(.column).define { flex in
            flex.addItem(titleLabel).width(100).height(24).marginTop(16)
            flex.addItem(collectionView).grow(1)
        }
        setUpDataSource()
    }
    
    func layout() {
        container.pin.all()
        container.flex.layout()
    }
    
    private func setUpDataSource() {
        self.dataSource =
        UICollectionViewDiffableDataSource<Int, LifeBenefitMyTown>(collectionView: self.collectionView) { (collectionView, indexPath, lifeBenefitMyTown) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LifeBenefitMytownItemCell", for: indexPath) as? LifeBenefitMytownItemCell
            cell?.configure(data: lifeBenefitMyTown)
            return cell
        }
    }
    
    public func configure(data:[LifeBenefitMyTown]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, LifeBenefitMyTown>()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 162, height: 120)
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .horizontal
        return layout
    }
}
