//
//  DLog.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation

///DlogMode type. Specify what details should be included to the log
public struct DlogMode: OptionSet {
    
    public let rawValue: UInt
    public init(rawValue: UInt)  { self.rawValue = rawValue }
    
    //MARK:- Options
    public static let none     = DlogMode(rawValue: 0)
    public static let fileName = DlogMode(rawValue: 1 << 0)
    public static let funcName = DlogMode(rawValue: 1 << 1)
    public static let line     = DlogMode(rawValue: 1 << 2)
    public static let date     = DlogMode(rawValue: 1 << 3)
    
    /// AllOptions - Enable all options, [FileName, FuncName, Line]
    public static let allOptions: DlogMode = [date, fileName, funcName, line]
    public static let fullCodeLocation: DlogMode = [fileName, funcName, line]
}


public struct Dlog {
    
    public typealias Printable = Any?
    
    public static var mode: DlogMode = .allOptions
    
    public static func print(_ items: Printable..., separator: String = " ", terminator: String = "\n", _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        let unwrapped = items.compactMap({ $0 ?? "\(Date()) \(file) \(function)[\(line)] found NiL" })
        #if DEBUG
            let prefix = modePrefix(Date(), file: file, function: function, line: line)
            let stringItem = unwrapped.map {"\($0)"} .joined(separator: separator)
            Swift.print("\(prefix)\(stringItem)", terminator: terminator)
        #endif
    }
    
    static func modePrefix(_ date: Date, file: String, function: String, line: Int) -> String {
        var result: String = ""
        
        if mode.contains(.date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
            
            let s = formatter.string(from: date)
            result += s
        }
        if mode.contains(.fileName) {
            let filename = file.lastPathComponent.stringByDeletingPathExtension
            result += "\(filename)."
        }
        if mode.contains(.funcName) {
            result += "\(function)"
        }
        if mode.contains(.line) {
            result += "[\(line)]"
        }
        
        if !result.isEmpty {
            result = result.trimmingCharacters(in: CharacterSet.whitespaces)
            result += ": "
        }
        
        return result
    }
}

/// String syntax sugar extension
public extension String {
    var ns: NSString {
        return self as NSString
    }
    var lastPathComponent: String {
        return ns.lastPathComponent
    }
    var stringByDeletingPathExtension: String {
        return ns.deletingPathExtension
    }
}
