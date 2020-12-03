//
//  PageControlViewController.swift
//  OnBoarding2
//
//  Created by Muhammad Rasyid khaikal on 15/05/20.
//  Copyright © 2020 Muhammad Rasyid khaikal. All rights reserved.
//

import UIKit

class PageControlForm: UIPageViewController {
    var orderedViewControllers: [UIViewController] = []
    var pageControl = UIPageControl()

    override init(transitionStyle _: UIPageViewController.TransitionStyle, navigationOrientation _: UIPageViewController.NavigationOrientation, options _: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.background

        let formScreen1 = FormScreen1()
        formScreen1.rootView = self

        let formScreen2 = FormScreen2()
        formScreen2.rootView = self

        let formScreen3 = FormScreen3()
        formScreen3.rootView = self

        let formScreen4 = FormScreen4()
        formScreen4.rootView = self

        orderedViewControllers = [
            formScreen1,
            formScreen2,
            formScreen3,
            formScreen4,
            FormScreen5(),
        ]
        dataSource = self
        delegate = self

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageControlForm: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted _: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = orderedViewControllers.lastIndex(of: pageContentViewController)!
    }

    func setView(index: Int) {
        setViewControllers([orderedViewControllers[index]], direction: .forward, animated: true, completion: nil)
    }

    func pageViewController(_: UIPageViewController, viewControllerBefore _: UIViewController) -> UIViewController? {
        return nil
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter _: UIViewController) -> UIViewController? {
        return nil
    }
}
