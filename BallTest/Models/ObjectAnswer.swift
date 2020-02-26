//
//  AnswerDB.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//
import Foundation
import RealmSwift

final class ObjectAnswer: Object {

    @objc dynamic var text: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var identifier: String = UUID().uuidString

    override static func primaryKey() -> String? {
        return "identifier"
    }

    static func setupModel(identifier: String, text: String) -> ObjectAnswer {
        let result = ObjectAnswer()

        result.text = text
        result.identifier = identifier

        return result
    }
}
