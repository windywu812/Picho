//
//  PageControlViewController.swift
//  OnBoarding2
//
//  Created by Muhammad Rasyid khaikal on 15/05/20.
//  Copyright © 2020 Muhammad Rasyid khaikal. All rights reserved.
//

import UIKit

class PageControlDescription: UIPageViewController {
    var orderedViewControllers: [UIViewController] = []
    var pageControl = UIPageControl()

    override init(transitionStyle _: UIPageViewController.TransitionStyle, navigationOrientation _: UIPageViewController.NavigationOrientation, options _: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.background

        orderedViewControllers = [
            DescriptionScreen1(),
            DescriptionScreen2(),
            DescriptionScreen3(),
            DescriptionScreen4(),
        ]
        dataSource = self
        delegate = self

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        configurePageControl()
    }

    private func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 75, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = Color.lightGreen
        pageControl.currentPageIndicatorTintColor = Color.green
        view.addSubview(pageControl)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageControlDescription: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted _: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = orderedViewControllers.lastIndex(of: pageContentViewController)!
    }

    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.lastIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.lastIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1

        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
}
