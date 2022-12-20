//
//  TopScrollViewController.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/25.
//

import UIKit
import PinLayout

class TopScrollViewController: UIViewController {
    
    private var viewControllers = [UIViewController]()
    private var currentPageIndex = 0
    
    private let container = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private var underlineSegmentItems = [
        UnderlineSegmentItem(key: 0, value: "추천", pageIndex: 0),
        UnderlineSegmentItem(key: 1, value: "라이프", pageIndex: 1)
    ]
    
    private lazy var underlineSegmentView = UnderlineSegmentView(
        spacing: 20.0,
        padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    ).then {
        $0.delegate = self
    }
    
    private lazy var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    ).then {
        $0.dataSource = self
        $0.isPagingEnabled = false
        if let scrollView = $0.view.subviews.filter({ $0.isKind(of: UIScrollView.self) }).first as? UIScrollView {
            scrollView.delegate = self
        }
        $0.view.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test0VC = Test0ViewController()
        let test1VC = Test1ViewController()
        
        viewControllers.append(test0VC)
        viewControllers.append(test1VC)
        self.pageViewController.addChild(test0VC)
        self.pageViewController.addChild(test1VC)
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        underlineSegmentView.resetUnderline()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    func configureUI() {
        underlineSegmentView.configureView(values: underlineSegmentItems, selectedIndex: 0)
        let firstViewController = viewControllers[underlineSegmentView.selectedItemIndex() ?? 0]
        self.pageViewController.setViewControllers(
            [firstViewController],
            direction: .forward,
            animated: false,
            completion: nil
        )
        
        self.addChild(pageViewController)
        view.addSubview(underlineSegmentView)
        view.addSubview(pageViewController.view)
    }
    
    func configureLayout() {
        underlineSegmentView.pin.top(view.pin.safeArea.top).horizontally().height(45)
        pageViewController.view.pin.below(of: underlineSegmentView).horizontally().bottom()
    }
    
    func displayChildPage(index: Int, animated: Bool) {
        movePage(willPosition: index, animated: animated)
        underlineSegmentView.configureView(values: underlineSegmentItems, selectedIndex: index)
    }
    
    // Navigate to next page
    func movePage(willPosition: Int, animated: Bool) {
        var direction: UIPageViewController.NavigationDirection = .forward
        if willPosition < (underlineSegmentView.selectedItemIndex() ?? 0) {
            direction = .reverse
        }
        
        let viewController = self.viewControllers[willPosition]
        self.currentPageIndex = willPosition
        DispatchQueue.main.async { [weak self] in
            self?.pageViewController.setViewControllers(
                [viewController],
                direction: direction,
                animated: animated,
                completion: nil
            )
        }
    }
}

extension TopScrollViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        if previousIndex < 0 {
            return nil
        }
        
        return viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard viewControllers.count > nextIndex else {
            return nil
        }
        
        return viewControllers[nextIndex]
    }
}

extension TopScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    }
}

extension TopScrollViewController: UnderlineSegmentViewDelegate {
    func selectedTabItem(item: UnderlineSegmentItem) {
        displayChildPage(index: item.pageIndex, animated: true)
    }
}


extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
