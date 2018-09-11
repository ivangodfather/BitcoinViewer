//
//  ViewModelType.swift
//  BitcoinViewer
//
//  Created by Ivan Ruiz Monjo on 10/09/2018.

//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
