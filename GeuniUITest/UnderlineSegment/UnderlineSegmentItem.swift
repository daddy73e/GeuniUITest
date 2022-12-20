//
//  UnderlineSegmentItem.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/11/25.
//

import Foundation

public struct UnderlineSegmentItem {
    public let key: Int
    public let value: String
    public var selected = false
    public var pageIndex: Int
    
    public var buttonID: String?
    public var programID: String?
    
    init(
        key: Int,
        value: String,
        selected: Bool = false,
        pageIndex: Int,
        buttonID: String? = nil,
        programID: String? = nil
    ) {
        self.key = key
        self.value = value
        self.selected = selected
        self.pageIndex = pageIndex
        self.buttonID = buttonID
        self.programID = programID
    }
}
