//
//  Answer.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation

struct Answer {
    var identifier: String
    var text: String
    var date = Date()
}

extension Answer {

    static func fromObjectAnswer(_ objectAnswer: ObjectAnswer) -> Answer {
    let result = Answer(identifier: objectAnswer.identifier, text: objectAnswer.text, date: objectAnswer.date)

        return result
    }

    func toPresentableAnswer() -> PresentableAnswer {
        let result = PresentableAnswer(text: text, date: date, identifier: identifier)

        return result
    }

    func toObjectAnswer() -> ObjectAnswer {
        let result = ObjectAnswer.setupModel(identifier: self.identifier, text: self.text)

        return result
    }
}
