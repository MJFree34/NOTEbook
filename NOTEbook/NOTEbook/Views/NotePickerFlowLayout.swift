//
//  CollectionPickerViewFlowLayout.swift
//  NOTEbook
//
//  Created by Matt Free on 6/20/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NotePickerFlowLayout: UICollectionViewFlowLayout {
    var mostRecentOffset: CGPoint = CGPoint()
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let offset = proposedContentOffset.x + collectionView.contentInset.left

        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - offset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - offset
            }
        })

        if velocity.x == 0 {
            return mostRecentOffset
        }

        if let cv = self.collectionView {
            let cvBounds = cv.bounds
            let half = cvBounds.size.width * 0.5;

            if let attributesForVisibleCells = layoutAttributesForElements(in: cvBounds) {

                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {

                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionView.ElementCategory.cell {
                        continue
                    }

                   if attributes.center.x == 0 || (attributes.center.x > (cv.contentOffset.x + half) && velocity.x < 0) {
                        continue
                    }

                    candidateAttributes = attributes
                }

                // Beautification step, I don't know why it works!
                if proposedContentOffset.x == -cv.contentInset.left {
                    return proposedContentOffset
                }

                guard  candidateAttributes != nil else { return mostRecentOffset }

                mostRecentOffset = CGPoint(x: floor(candidateAttributes!.center.x - half), y: proposedContentOffset.y)

                return mostRecentOffset
            }
        }
        
        // fallback
        mostRecentOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        return mostRecentOffset
    }
}
