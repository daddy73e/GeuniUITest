//
//  ViewController.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/05/31.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class ViewController: UIViewController {
    
    enum Section: CaseIterable {
        case main
    }
    //test1
    //test
    //    var arr = ["Zedd", "Alan Walker", "David Guetta", "Avicii", "Marshmello", "Steve Aoki", "R3HAB", "Armin van Buuren", "Skrillex", "Illenium", "The Chainsmokers", "Don Diablo", "Afrojack", "Tiesto", "KSHMR", "DJ Snake", "Kygo", "Galantis", "Major Lazer", "Vicetone"
    //    ]
    var arr = [
        LifeBenefit(id: "001", lifeBenefitType: .fortune,
                    fortunes: [
                        LifeBenefitFortune(title: "오늘의 한 줄 운세",
                                           content: "진실하면 마음과 마음이 통하는 하루입니다.",
                                           url: "", imageUrl: "", backgroundColor: "")]),
        LifeBenefit(id: "002", lifeBenefitType: .event,
                    events: [
                        LifeBenefitEvent(title: "이벤트1", url: "", imageUrl : "", backgroundColor: ""),
                        LifeBenefitEvent(title: "이벤트2", url: "", imageUrl : "", backgroundColor: "")
                    ]),
        LifeBenefit(id: "003", lifeBenefitType: .solQuiz,
                    solQuizs: [
                        LifeBenefitSolQuiz(solQuize: "퀴즈 문제 퀴즈 문제 퀴즈 문제 퀴즈 문제 퀴즈 문제 퀴즈 문제 퀴즈 문제 퀴즈 문제 퀴즈 문제 ", url: "", imageUrl: "")
                    ]),
        LifeBenefit(id: "004", lifeBenefitType: .heyYoungQuiz,
                    heyYoungQuizs: [
                        LifeBenefitHeyYoungQuiz(quizTitle: "quiz", url: "", imageUrl: "", backgroundColor: "", buttonTitle: "퀴즈 참여하기")
                    ])
        
    ]
    
    
    var dataSource: UICollectionViewDiffableDataSource<Section, LifeBenefit>!
    // dev update
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: .init()).then {
        
        $0.backgroundColor = .systemBackground
        $0.register(LifeBenefitFortuneCell.self, forCellWithReuseIdentifier: "LifeBenefitFortuneCell")
        $0.register(LifeBenefitEventCell.self, forCellWithReuseIdentifier: "LifeBenefitEventCell")
        $0.register(LifeBenefitSolQuizeCell.self, forCellWithReuseIdentifier: "LifeBenefitSolQuizeCell")
        $0.register(LifeBenefitImageButtonCell.self, forCellWithReuseIdentifier: "LifeBenefitImageButtonCell")
    }
    
    let pagerView = PagerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = self.createLayout()
        self.view.addSubview(collectionView)
        self.view.addSubview(pagerView)
        self.setupDataSource()
        self.performQuery(with: nil)
    }
    
    func setupDataSource() {
        self.dataSource =
        UICollectionViewDiffableDataSource<Section, LifeBenefit>(collectionView: self.collectionView) { (collectionView, indexPath, lifeBenefit) -> UICollectionViewCell? in
            switch lifeBenefit.lifeBenefitType {
            case .fortune:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LifeBenefitFortuneCell", for: indexPath) as? LifeBenefitFortuneCell
                if let data = lifeBenefit.fortunes?[0] {
                    cell?.configure(data: data)
                }
                return cell
            case .event:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LifeBenefitEventCell", for: indexPath) as? LifeBenefitEventCell
                if let data = lifeBenefit.events?[0] {
                    cell?.configure(data:data)
                }
                return cell
            case .solQuiz:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LifeBenefitSolQuizeCell", for: indexPath) as? LifeBenefitSolQuizeCell
                if let data = lifeBenefit.solQuizs?[0] {
                    cell?.configure(data: data)
                }
                return cell
            case .heyYoungQuiz:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LifeBenefitImageButtonCell", for: indexPath) as? LifeBenefitImageButtonCell
                if let data = lifeBenefit.heyYoungQuizs?[0] {
                    cell?.configure(data: data)
                }
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    func performQuery(with filter: String?) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LifeBenefit>()
        snapshot.appendSections([.main])
        snapshot.appendItems(arr)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let columns = 1
            let spacing = CGFloat(10)
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(30))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(30)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 20, bottom: 45, trailing: 20)
            
            return section
        }
        return layout
    }
}

extension ViewController {
    func layoutViews() {
        collectionView.pin.all(self.view.pin.safeArea)
            .marginBottom(100)
        pagerView.pin.bottom(self.view.pin.safeArea.bottom).height(100).left().right()
    }
}
