//
//  PrimePumpEvent.swift
//  RileyLink
//
//  Created by Pete Schwamb on 3/8/16.
//  Copyright © 2016 Pete Schwamb. All rights reserved.
//

import Foundation

public class PrimePumpEvent: PumpEvent {
    public let length: Int
    let timestamp: NSDateComponents
    let amount: Double
    let primeType: String
    let programmedAmount: Double
    
    public required init?(availableData: NSData, pumpModel: PumpModel) {
        length = 10
        
        guard length <= availableData.length else {
            return nil
        }
        
        func d(idx:Int) -> Int {
            return Int(availableData[idx] as UInt8)
        }
        
        timestamp = TimeFormat.parse5ByteDate(availableData, offset: 5)
        amount = Double(d(4) << 2) / 40.0
        programmedAmount = Double(d(2) << 2) / 40.0
        primeType = programmedAmount == 0 ? "manual" : "fixed"
    }
    
    public var dictionaryRepresentation: [String: AnyObject] {
        return [
            "_type": "Prime",
            "amount": amount,
            "programmedAmount": programmedAmount,
            "timestamp": TimeFormat.timestampStr(timestamp),
            "primeType": primeType,
        ]
    }
}
