//
//  PageControlViewController.swift
//  OnBoarding2
//
//  Created by Muhammad Rasyid khaikal on 15/05/20.
//  Copyright © 2020 Muhammad Rasyid khaikal. All rights reserved.
//

import UIKit

class PageControlForm: UIPageViewController {
    
    var orderedViewControllers : [UIViewController] = []
    var pageControl = UIPageControl()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.background
        
        let formScreen1 = FormScreen1()
        formScreen1.rootViewS1 = self
        
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
            FormScreen5()
        ]
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageControlForm: UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.lastIndex(of: pageContentViewController)!
    }
    
    func setView(index:Int) {
        self.setViewControllers([orderedViewControllers[index]], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}
