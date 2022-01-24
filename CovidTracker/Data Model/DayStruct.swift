//
//  DayStruct.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 07.12.2020.
//

import SwiftUI

public struct OneDate: Hashable, Codable, Identifiable {
    public var id: UUID
    public var date: Int
    public var positive: Int
    public var negative: Int
    public var totalTestResults: Int
    public var recovered: Int
    public var deaths: Int
    public var hospitalized: Int
}
