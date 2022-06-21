//
//  MoneyverseViewController.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/06/15.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class MoneyverseViewController: UIViewController {
    
    private let container = UIView().then {
        $0.backgroundColor = UIColor.yellow
    }
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: .init()).then {
        
        $0.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
}

extension MoneyverseViewController {
    func configureUI() {
        self.view.backgroundColor = .white
        self.view.flex.define { flex in
            flex.addItem(container)
        }
    }
    
    func layout() {
        container.pin.all(self.view.pin.safeArea)
    }
}
