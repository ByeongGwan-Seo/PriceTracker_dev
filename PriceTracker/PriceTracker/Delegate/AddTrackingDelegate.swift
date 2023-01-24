//
//  AddTrackingDelegate.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/24.
//

import Foundation

protocol AddTrackingDelegate: AnyObject {
    func didSelectSave(trackingInfo: TrackingInfo)
}
