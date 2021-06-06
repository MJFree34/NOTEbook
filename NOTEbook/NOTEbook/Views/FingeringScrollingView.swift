//
//  FingeringScrollingView.swift
//  NOTEbook
//
//  Created by Matt Free on 11/21/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringScrollingView: UIView {
    var fingerings = [Fingering]() {
        didSet {
            for fingeringScrollView in fingeringScrollViews {
                fingeringScrollView.removeFromSuperview()
            }
            
            fingeringScrollViews.removeAll()
            
            for fingering in fingerings {
                let fingeringScrollView = FingeringScrollView(fingering: fingering)
                fingeringScrollViews.append(fingeringScrollView)
            }
            
            width = ChartsController.shared.currentChart.instrument.fingeringWidth
            scrollView.contentSize = CGSize(width: CGFloat(width * fingeringScrollViews.count), height: LetterArrowViewController.fingeringHeight)
            addFingeringScrollViews()
            
            pageControl.numberOfPages = fingeringScrollViews.count
            pageControlValueChanged(to: 0, animated: false)
        }
    }
    
    private lazy var pageControl: NotebookPageControl = {
        let control = NotebookPageControl(pages: 0)
        control.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        return control
    }()
    
    private lazy var scrollView: NotebookScrollView = {
        let sv = NotebookScrollView()
        sv.delegate = self
        return sv
    }()
    
    private var width = 0 {
        didSet {
            scrollViewWidthAnchor.constant = CGFloat(width)
        }
    }
    
    private var scrollViewWidthAnchor: NSLayoutConstraint!
    private var fingeringScrollViews = [FingeringScrollView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: LetterArrowViewController.fingeringHeight),
            
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        scrollViewWidthAnchor = scrollView.widthAnchor.constraint(equalToConstant: 0)
        scrollViewWidthAnchor.isActive = true
        width = ChartsController.shared.currentChart.instrument.fingeringWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addFingeringScrollViews() {
        for (index, fingeringScrollView) in fingeringScrollViews.enumerated() {
            fingeringScrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(fingeringScrollView)
            
            NSLayoutConstraint.activate([
                fingeringScrollView.heightAnchor.constraint(equalToConstant: LetterArrowViewController.fingeringHeight),
                fingeringScrollView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                fingeringScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                             constant: CGFloat(ChartsController.shared.currentChart.instrument.fingeringWidth * index)),
                fingeringScrollView.widthAnchor.constraint(equalToConstant: CGFloat(ChartsController.shared.currentChart.instrument.fingeringWidth))
            ])
        }
    }
    
    @objc private func pageControlChanged(sender: UIPageControl) {
        pageControlValueChanged(to: sender.currentPage)
    }
    
    private func pageControlValueChanged(to value: Int, animated: Bool = true) {
        pageControl.currentPage = value
        scrollView.setContentOffset(CGPoint(x: CGFloat(width * value), y: 0), animated: animated)
    }
}

extension FingeringScrollingView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.size.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
