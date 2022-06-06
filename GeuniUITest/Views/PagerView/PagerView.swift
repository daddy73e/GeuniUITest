//
//  PagerView.swift
//  GeuniUITest
//
//  Created by Yeongeun Song on 2022/06/01.
//

import FlexLayout
import PinLayout
import Then
import UIKit

class PagerView: UIView {
    
    public var pageItem:PageItem?
    private var currentPage: Int = 1
    private var currentOffset: CGFloat = 0
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: .init()).then {
        $0.bounces = false
        $0.decelerationRate = .fast
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.register(PagerItemCell.self,
                    forCellWithReuseIdentifier: PagerItemCell.identifier)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "이벤트"
        $0.textColor = .white
    }
    
    private let currentPageLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .right
        $0.sizeToFit()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    public func configItem(pageItem:PageItem) {
        self.pageItem = pageItem
        
        self.collectionView.reloadData()
    }
    
    private func configure() {
        self.addSubview(collectionView)
        self.addSubview(titleLabel)
        self.addSubview(currentPageLabel)
        self.currentPageLabel.text = "\(currentPage)/\(self.pageItem?.images?.count ?? 0)"
        self.configCollectionView()
    }
    
    private func layout() {
        collectionView.pin.all()
        titleLabel.pin.top().left().margin(20).sizeToFit()
        currentPageLabel.pin.top().right().margin(20).width(100).height(20)
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func targetContentOffset(withVelocity velocity: CGPoint) -> CGPoint {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        if velocity.x < 0 {
            if currentPage == 1 {
                return CGPoint.zero
            }
            currentPage = currentPage - 1
        } else if velocity.x > 0 {
            if currentPage == self.pageItem?.images?.count {
                return CGPoint(x: currentOffset, y: 0)
            }
            currentPage = currentPage + 1
        }
        
        let additional = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing)
        let updatedOffset = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) * CGFloat(currentPage) - additional
        
        currentOffset = updatedOffset
        return CGPoint(x: updatedOffset, y: 0)
    }
    
}

extension PagerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageItem?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagerItemCell.identifier, for: indexPath)
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .blue
        } else {
            cell.backgroundColor = .green
        }
        return cell
    }
}

extension PagerView: UICollectionViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.currentPageLabel.text = "\(currentPage)/\(self.pageItem?.images?.count ?? 0)"
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let point = self.targetContentOffset(withVelocity: velocity)
        targetContentOffset.pointee = point
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: velocity.x,
                       options: .allowUserInteraction, animations: {
            self.collectionView.setContentOffset(point, animated: true)
        }, completion: nil)
    }
}
