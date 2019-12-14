//
//  Section.swift
//  JYHelpers
//
//  Created by Jake Young on 4/18/19.
//  Copyright © 2019 Jake Young. All rights reserved.
//

import Foundation


public protocol SimpleDataSource {
    associatedtype RecordType
    var items: [RecordType] { get set }
}

extension SimpleDataSource {
    public func getItem(at indexPath: IndexPath) -> RecordType {
        return items[indexPath.item]
    }
    public var numberOfItems: Int {
        return items.count
    }
    public var numberOfSections: Int {
        return 1
    }
}

public struct Section<T: Comparable>: SimpleDataSource, Comparable, Collection {
    
    public static func < (lhs: Section<T>, rhs: Section<T>) -> Bool {
        return lhs.title ?? "" < rhs.title ?? ""
    }
    public typealias RecordType = T
    public let title: String?
    public var items: [T]
    public init(title: String?, items: [T]) {
        self.title = title
        self.items = items
    }
    // Required nested types, that tell Swift what our collection contains
    public typealias Index = Array<T>.Index
    public typealias Element = T
    
    // The upper and lower bounds of the collection, used in iterations
    public var startIndex: Index { return items.startIndex }
    public var endIndex: Index { return items.endIndex }
    
    // Required subscript, based on a dictionary index
    public subscript(index: Index) -> Iterator.Element {
        get { return items[index] }
    }
    
    // Method that returns the next index when iterating
    public func index(after i: Index) -> Index {
        return items.index(after: i)
    }
    
}

extension SimpleDataSource where RecordType: Comparable {
    public mutating func sort() {
        self.items.sort()
    }
}


public protocol ComplexDataSource {
    associatedtype SectionType: SimpleDataSource
    var sections: [SectionType] { get set }
    var filteredSections: [SectionType] { get set }
    func applyFilters()
}

public extension ComplexDataSource {
    var numberOfSections: Int {
        return filteredSections.count
    }
    func numberOfItems(in section: Int) -> Int { return filteredSections[section].numberOfItems }
    
    func getItem(at indexPath: IndexPath) -> SectionType.RecordType {
        return filteredSections[indexPath.section].getItem(at: indexPath)
    }
    
    mutating func applyFilters() {
        filteredSections = sections
    }
}
