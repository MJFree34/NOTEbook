//
//  CollectionPickerView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/20/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NotePickerForwardDelegate: NSObject, UICollectionViewDelegate {
    init(picker: NotePicker) {
        self.picker = picker
    }
    
    weak var delegate: UICollectionViewDelegate?
    
    private weak var picker: NotePicker?
    
    override func forwardingTarget(for selector: Selector!) -> Any? {
        if let p = picker, p.responds(to: selector) {
            return p
        } else if let d = delegate, d.responds(to: selector) {
            return d
        }
        return super.responds(to: selector)
    }
    
    override public func responds(to selector: Selector!) -> Bool {
        if let p = picker, p.responds(to: selector) {
            return true
        } else if let d = delegate, d.responds(to: selector) {
            return true
        }
        return super.responds(to: selector)
    }
}

class NotePicker: UIView {
    let collectionView: UICollectionView
    
    var cellSpacing: CGFloat = 10
    
    var cellSize: CGFloat = 100
    
    var selectedIndex: Int = 0
    
    weak var dataSource: UICollectionViewDataSource? {
        didSet {
            collectionView.dataSource = dataSource
        }
    }
    
    weak var delegate: UICollectionViewDelegate? {
        didSet {
            forwardDelegate.delegate = delegate
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: cellSize)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectItem(at index: Int, animated: Bool = false) {
        self.selectItem(at: index, animated: animated, scroll: true, notifySelection: true)
    }
    
    func reloadData() {
        invalidateIntrinsicContentSize()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
        if collectionView.numberOfItems(inSection: 0) > 0 {
            selectItem(at: selectedIndex, animated: false)
        }
    }
    
    private var flowLayout: UICollectionViewFlowLayout? {
        return collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    private var forwardDelegate: NotePickerForwardDelegate!
    
    private var selectedTapped = false
    
    private func initialize() {
        addSubview(collectionView)
        
        forwardDelegate = NotePickerForwardDelegate(picker: self)
        
        collectionView.delegate = forwardDelegate
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.backgroundColor = UIColor.clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addMask()
        flowLayout?.scrollDirection = .horizontal
        flowLayout?.invalidateLayout()
    }
    
    private func offsetForItem(at index: Int) -> CGFloat {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        let firstSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: firstIndexPath)
        var offset: CGFloat = collectionView.bounds.width / 2 - firstSize.width / 4
        
        for i in 0 ..< index {
            let indexPath = IndexPath(item: i, section: 0)
            let cellSize = collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: indexPath)
            offset += cellSize.width + cellSpacing
        }
        
        let selectedIndexPath = IndexPath(item: index, section: 0)
        let selectedSize = collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: selectedIndexPath)
        offset -= collectionView.bounds.width / 2 - selectedSize.width / 2
        
        return offset
    }
    
    private func scrollToItem(at index: Int, animated: Bool = false) {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: animated)
    }
    
    private func selectItem(at index: Int, animated: Bool, scroll: Bool, notifySelection: Bool) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: UICollectionView.ScrollPosition())
        if scroll {
            scrollToItem(at: index, animated: animated)
        }
        
        selectedIndex = index
        delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    private func addMask() {
        collectionView.layer.mask = {
            let maskLayer = CAGradientLayer()
            maskLayer.frame = collectionView.bounds
            maskLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.black.cgColor,
                UIColor.black.cgColor,
                UIColor.clear.cgColor]
            maskLayer.locations = [0.0, 0.33, 0.66, 1.0]
            maskLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            maskLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            return maskLayer
        }()
    }
}

// MARK: - UICollectionViewDelegate
extension NotePicker: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTapped = true
        selectItem(at: indexPath.row, animated: true)
    }
}

// MARK: - Layout
extension NotePicker {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        reloadData()
        
        collectionView.frame = collectionView.superview!.bounds
        collectionView.layer.mask?.frame = collectionView.bounds
        if collectionView.numberOfItems(inSection: 0) > 0 {
            selectItem(at: selectedIndex)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension NotePicker: UIScrollViewDelegate {
    private func didScroll(end: Bool) {
        let center = convert(collectionView.center, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: center) {
            selectItem(at: indexPath.item, animated: true, scroll: end, notifySelection: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
        didScroll(end: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        if !decelerate {
            didScroll(end: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
        
        if !selectedTapped {
            didScroll(end: false)
        }
        
        let center = convert(collectionView.center, to: collectionView)
        let totalCells = collectionView.numberOfItems(inSection: 0)
        
        if center.x < 209.5 {
            scrollToItem(at: 0)
        } else if center.x > 209.5 + 87.0 * CGFloat(totalCells - 1) {
            scrollToItem(at: totalCells - 1)
        }
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        collectionView.layer.mask?.frame = collectionView.bounds
        CATransaction.commit()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        selectedTapped = false
    }
}

extension NotePicker: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let firstIndexPath = IndexPath(item: 0, section: section)
        let firstSize = self.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: firstIndexPath)
        let lastIndexPath = IndexPath(item: collectionView.numberOfItems(inSection: section) - 1, section: section)
        let lastSize = self.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: lastIndexPath)
        return UIEdgeInsets(top: 0, left: (collectionView.bounds.size.width - firstSize.width / 2) / 2, bottom: 0, right: (collectionView.bounds.size.width - lastSize.width / 2) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
