//
//  TabBarUnderlineViewController.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/21.
//

import UIKit
import FlexLayout
import PinLayout
import Then
import HMSegmentedControl

class TabBarUnderlineViewController: UIViewController {

    private let container = UIView()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    private let scrollContentView = UIView()
    private lazy var segmentControl = NoSwipeSegmentedControl(items: ["testtest", "tes", "test1", "test1test1test1", "t","test"]).then {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func segmentedControlValueChanged(_ segmentControl: UISegmentedControl) {
        let selectedIndex = segmentControl.selectedSegmentIndex
        if selectedIndex >= 0 {
            let offset = segmentControl.widthForSegment(at: selectedIndex)
            
            print(offset)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configureLayout()
    }
}

private extension TabBarUnderlineViewController {
    func configureUI() {
        self.view.addSubview(self.container)
        self.container.flex.define { flex in
            flex.addItem(scrollView).marginHorizontal(0).height(Constants.segmentHeight)
        }
        scrollView.flex.define { flex in
            flex.addItem(scrollContentView).width(500).height(Constants.segmentHeight)
        }
        
        scrollContentView.flex.define { flex in
            flex.addItem(segmentControl).height(Constants.segmentHeight)
        }
    }
    
    func configureLayout() {
        self.container.pin.all(self.view.pin.safeArea)
        self.container.flex.layout()
        self.scrollView.contentSize = CGSize(
            width: scrollContentView.frame.width,
            height: scrollContentView.frame.height
        )
    }
}

public struct Constants {
    public static let segmentHeight = 50.0
    public static let fontSize = 15.0
}

class NoSwipeSegmentedControl: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - height
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = .green
        self.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
//        UIView.animate(
//            withDuration: 0.2,
//            delay: 0,
//            options: .curveEaseInOut,
//            animations: {
//                self.underlineView.frame.origin.x = underlineFinalXPosition
//            }
//        )
    }
    
    override var tintColor: UIColor! {
        didSet {
            setTitleTextAttributes([.foregroundColor: tintColor!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular)], for: .normal)
        }
    }
    
    override var selectedSegmentTintColor: UIColor? {
        didSet {
            setTitleTextAttributes([.foregroundColor: selectedSegmentTintColor ?? tintColor!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular)], for: .selected)
        }
    }
    
    private func setup() {
        self.apportionsSegmentWidthsByContent = true
        backgroundColor = .clear
        let clearImage = UIImage(color: .clear, size: CGSize(width: 1, height: 1))
        setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        setBackgroundImage(clearImage, for: .selected, barMetrics: .default)
        setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        setTitleTextAttributes([.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular)], for: .normal)
        setTitleTextAttributes([.foregroundColor: tintColor!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular)], for: .selected)
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.init(data: image.pngData()!)!
    }
}
