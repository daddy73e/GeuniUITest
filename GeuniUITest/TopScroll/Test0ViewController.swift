//
//  Test0ViewController.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/25.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class Test0ViewController: UIViewController {

    private var items = [String]()
    
    private let container = UIView()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    ).then { [weak self] in
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: TestCollectionViewCell.identifier)
    }
    
    private func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.bounds.width, height: 50)
        return layout
    }
    
//    private func makeLayout() -> UICollectionViewCompositionalLayout {
//        let spacing = CGFloat(10)
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .estimated(50))
//
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: itemSize,
//            subitems: [item]
//        )
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = spacing
//        section.contentInsets = .zero
//
//        return UICollectionViewCompositionalLayout(section: section)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.items = [
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트",
            "테스트",
            "테스트테스트테스트",
            "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트"
        ]
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    
    private func configureUI() {
        self.view.backgroundColor = .yellow
        self.view.addSubview(container)
        self.container.flex.define { flex in
            flex.addItem(self.collectionView).grow(1)
        }
    }
    
    private func configureLayout() {
        container.pin.all(self.view.pin.safeArea)
        container.flex.layout()
    }
}

extension Test0ViewController: UICollectionViewDelegate {
    
}

extension Test0ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TestCollectionViewCell.identifier,
            for: indexPath
        ) as? TestCollectionViewCell {
            cell.configure(text: items[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
