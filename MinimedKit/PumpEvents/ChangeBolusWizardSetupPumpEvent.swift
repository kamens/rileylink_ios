//
//  ChangeBolusWizardSetupPumpEvent.swift
//  RileyLink
//
//  Created by Pete Schwamb on 3/8/16.
//  Copyright © 2016 Pete Schwamb. All rights reserved.
//

import Foundation

public class ChangeBolusWizardSetupPumpEvent: PumpEvent {
    public let length: Int
    let timestamp: NSDateComponents
    
    public required init?(availableData: NSData, pumpModel: PumpModel) {
        if pumpModel.larger {
            length = 144
        } else {
            length = 124
        }
        
        guard length <= availableData.length else {
            return nil
        }
        
        timestamp = TimeFormat.parse5ByteDate(availableData, offset: 2)
    }
    
    public var dictionaryRepresentation: [String: AnyObject] {
        return [
            "_type": "ChangeBolusWizardSetup",
            "timestamp": TimeFormat.timestampStr(timestamp),
        ]
    }
}
