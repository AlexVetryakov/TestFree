//
//  PresentableAnswer.swift
//  BallTest
//
//  Created by Developer on 9/29/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation
import RxDataSources

private let timeDateFormat = "HH:mm dd MMM yyyy"
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = timeDateFormat

    return formatter
}()

struct PresentableAnswer: IdentifiableType, Equatable {
    var text: String
    let identity: String
    let dateRepresentation: String

    init(text: String, date: Date, identifier: String) {
        self.text = text
        self.dateRepresentation = dateFormatter.string(from: date)
        self.identity = identifier
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}
