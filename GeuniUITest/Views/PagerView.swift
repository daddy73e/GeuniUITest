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
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: .init()).then {
        $0.bounces = false
        $0.decelerationRate = .fast
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.register(PagerItemCell.self,
                    forCellWithReuseIdentifier: "PagerItemCell")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "이벤트"
        $0.textColor = .white
    }
    
    private let currentPageLabel = UILabel().then {
        $0.text = "1"
        $0.textColor = .white
        $0.textAlignment = .right
        $0.sizeToFit()
    }
    
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func configure() {
        self.addSubview(collectionView)
        self.addSubview(titleLabel)
        self.addSubview(currentPageLabel)
        self.configCollectionView()
    }
    
    private func layout() {
        collectionView.pin.all()
        titleLabel.pin.top().left().margin(20).sizeToFit()
        currentPageLabel.pin.top().right().margin(20).width(100).height(20)
    }
    
    func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = CGSize(width: 0, height: self.bounds.height)
        layout.footerReferenceSize = CGSize(width: 0, height: self.bounds.height)
        return layout
    }
}

extension PagerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagerItemCell", for: indexPath)
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .blue
        } else {
            cell.backgroundColor = .green
        }
        return cell
    }
}

extension PagerView: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let point = self.targetContentOffset(scrollView, withVelocity: velocity)
        targetContentOffset.pointee = point
        self.currentPageLabel.text = "\(self.currentPage)"
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
            self.collectionView.setContentOffset(point, animated: true)
        }, completion: nil)
    }
    
    func targetContentOffset(_ scrollView: UIScrollView, withVelocity velocity: CGPoint) -> CGPoint {
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage = currentPage - 1
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = currentPage + 1
        }
        
        let additional = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) - flowLayout.headerReferenceSize.width
        
        let updatedOffset = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) * CGFloat(currentPage) - additional
        
        previousOffset = updatedOffset
        
        return CGPoint(x: updatedOffset, y: 0)
    }
}
