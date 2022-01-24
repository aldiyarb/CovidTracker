//
//  CasesStruct.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 03.12.2020.
//

import SwiftUI

public struct StateStruct: Hashable, Codable, Identifiable {
    public var id: UUID
    public var date: Int
    public var state: String
    public var positive: Int
    public var negative: Int
    public var totalTestResults: Int
    public var hospitalized: Int
    public var recovered: Int
    public var deaths: Int
}
