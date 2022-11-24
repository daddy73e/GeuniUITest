//
//  TabBarViewController.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/16.
//

import UIKit
import FlexLayout
import PinLayout
import Then

class TabBarViewController: UIViewController {
    
    let scollView = UIScrollView().then {
        $0.backgroundColor = .yellow
        $0.translatesAutoresizingMaskIntoConstraints = false  
    }
    var segment:UISegmentedControl?
    var segmentWidth = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    private func configureUI() {
        let items = ["All FruitsAll FruitsAll FruitsAll Fruits", "Orange", "Grapes", "Banana", "django"]
        segment = UISegmentedControl(items: items)
        for (index, element) in items.enumerated() {
            let size = element.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]) //you can change font as you want
            segment?.setWidth(size.width, forSegmentAt: index)
            segmentWidth = segmentWidth + size.width
        }
        
        segment?.selectedSegmentIndex = 0
        segment?.tintColor = UIColor.black
        segment?.addTarget(self, action: #selector(self.filterApply), for: UIControl.Event.valueChanged)
        
        if let segment = segment {
            scollView.addSubview(segment)
        }
        self.view.addSubview(scollView)
    }
    
    private func configureLayout() {
        self.view.pin.all()
        scollView.pin.top().left().width(segmentWidth).marginTop(100).height(50)
        self.segment?.pin.vertically().left().width(segmentWidth)
    }
    
    
    
    
    @objc private func filterApply(segment:UISegmentedControl) -> Void {
        print("Selected Index : \(segment.selectedSegmentIndex)")
    }
    
}
