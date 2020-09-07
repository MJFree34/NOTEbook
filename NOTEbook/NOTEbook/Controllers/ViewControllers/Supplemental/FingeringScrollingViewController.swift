//
//  FingeringScrollingViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 9/6/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringScrollingViewController: UIViewController {
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.currentPageIndicatorTintColor = UIColor(named: "Black")!
        control.pageIndicatorTintColor = UIColor(named: "LightAqua")!
        control.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 14.0, *) {
            control.allowsContinuousInteraction = false
        }
        
        return control
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.bounces = true
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.delegate = self
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    var fingerings = [Fingering]() {
        didSet {
            for fingeringScrollingView in fingeringScrollingViews {
                fingeringScrollingView.removeFromSuperview()
            }
            
            fingeringScrollingViews.removeAll()
            
            for fingering in fingerings {
                let fingeringScrollingView = FingeringScrollingView(fingering: fingering)
                fingeringScrollingViews.append(fingeringScrollingView)
            }
            
            scrollView.contentSize = CGSize(width: CGFloat(ChartsController.shared.currentChart.instrument.fingeringWidth * fingeringScrollingViews.count), height: LetterArrowViewController.fingeringHeight)
            
            scrollViewWidthAnchor.constant = CGFloat(ChartsController.shared.currentChart.instrument.fingeringWidth)
            
            addFingeringScrollingViews()
            
            pageControl.numberOfPages = fingeringScrollingViews.count
            
            if pageControl.numberOfPages > 1 {
                pageControlValueChanged(to: 0, animated: false)
            }
            
            view.layoutIfNeeded()
        }
    }
    
    private var scrollViewWidthAnchor: NSLayoutConstraint!
    
    private var fingeringScrollingViews = [FingeringScrollingView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: LetterArrowViewController.fingeringHeight),
            
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        scrollViewWidthAnchor = scrollView.widthAnchor.constraint(equalToConstant: CGFloat(ChartsController.shared.currentChart.instrument.fingeringWidth))
        scrollViewWidthAnchor.isActive = true
    }
    
    func addFingeringScrollingViews() {
        for (index, fingeringScrollingView) in fingeringScrollingViews.enumerated() {
            fingeringScrollingView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(fingeringScrollingView)
            
            NSLayoutConstraint.activate([
                fingeringScrollingView.heightAnchor.constraint(equalToConstant: LetterArrowViewController.fingeringHeight),
                fingeringScrollingView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                fingeringScrollingView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(ChartsController.shared.currentChart.instrument.fingeringWidth * index)),
                fingeringScrollingView.widthAnchor.constraint(equalToConstant: CGFloat(ChartsController.shared.currentChart.instrument.fingeringWidth))
            ])
        }
    }
    
    @objc func pageControlChanged(sender: UIPageControl) {
        pageControlValueChanged(to: sender.currentPage)
    }
    
    func pageControlValueChanged(to value: Int, animated: Bool = true) {
        pageControl.currentPage = value
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        scrollView.setContentOffset(CGPoint(x: 1.0 / CGFloat(fingeringScrollingViews.count - 1) * maximumHorizontalOffset * CGFloat(pageControl.currentPage), y: currentVerticalOffset), animated: animated)
    }
}

extension FingeringScrollingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
