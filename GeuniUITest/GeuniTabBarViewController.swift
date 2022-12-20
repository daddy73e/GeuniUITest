//
//  GeuniTabBarViewController.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/22.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class GeuniTabBarViewController: UIViewController {

    lazy var tabbarView = UnderlineSegmentView(
        normalTitleColor: .blue,
        selectedTitleColor: .gray,
        spacing: 5.0,
        padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    ).then {
        $0.delegate = self
    }
    
    var tabItems = [
        UnderlineSegmentItem(key: 0, value: "test", pageIndex: 0),
        UnderlineSegmentItem(key: 1, value: "testtesttest", pageIndex: 1),
    ]
    
    let container = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tabbarView.configureView(values: tabItems, selectedIndex: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabbarView.resetUnderline()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
}

extension GeuniTabBarViewController: UnderlineSegmentViewDelegate {
    func selectedTabItem(item: UnderlineSegmentItem) {
        print(item.key)
    }
}

private extension GeuniTabBarViewController {
    func configureUI() {
        self.view.flex.define { flex in
            flex.addItem(container)
        }
        
        container.flex.define { flex in
            flex.addItem(tabbarView).height(50).horizontally(0).marginRight(100)
                .backgroundColor(.lightGray)
        }
    }
    
    func configureLayout() {
        self.container.pin.all(self.view.pin.safeArea)
        self.container.flex.layout()
    }
}
