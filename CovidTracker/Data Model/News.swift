//
//  News.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 09.12.2020.
//

import SwiftUI

public struct News: Hashable, Codable, Identifiable {
    public var id: UUID
    public var title: String
    public var url: String
}
