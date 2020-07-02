//
//  FingeringPageViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/19/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.currentPageIndicatorTintColor = UIColor(named: "Black")!
        control.pageIndicatorTintColor = UIColor(named: "LightAqua")!
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
    }()
    
    var fingerings = [Fingering]() {
        didSet {
            fingeringViewControllers = [FingeringViewController]()
            
            for fingering in fingerings {
                let vc = FingeringViewController()
                vc.fingering = fingering
                fingeringViewControllers.append(vc)
            }
            
            pageControl.numberOfPages = fingeringViewControllers.count
            
            pageViewController.setViewControllers([fingeringViewControllers[0]], direction: .forward, animated: false, completion: nil)
            
            NSLayoutConstraint.activate([
                pageViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                pageViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                pageControl.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor, constant: 30),
                pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        }
    }
    
    private var fingeringViewControllers = [FingeringViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        add(pageViewController)
        
        view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = fingeringViewControllers.firstIndex(of: viewController as! FingeringViewController) {
            if viewControllerIndex != 0 {
                // Go to previous vc in array
                return fingeringViewControllers[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = fingeringViewControllers.firstIndex(of: viewController as! FingeringViewController) {
            if viewControllerIndex < fingeringViewControllers.count - 1 {
                // Go to next vc in array
                return fingeringViewControllers[viewControllerIndex + 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // Set the pageControl.currentPage to the index of the current vc in fingeringVCs
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = fingeringViewControllers.firstIndex(of: viewControllers[0] as! FingeringViewController) {
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
}
