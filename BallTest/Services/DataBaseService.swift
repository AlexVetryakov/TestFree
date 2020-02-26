//
//  DataBaseService.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import Foundation
import RealmSwift

private let dataBaseInitializedUDKey = "dataBaseInitializedUDKey"

final class DataBaseService {

    private let realm: Realm!
    private var token: NotificationToken!
    private let observers = NSHashTable<AnyObject>(options: NSPointerFunctions.Options.weakMemory)

    init() {
        do {
            try realm = Realm()
        } catch {
            realm = nil
        }
        token = realm.observe({ [weak self] notification, _ in
            if notification == .didChange {
                self?.observers.allObjects.forEach { value in
                    (value as? Reloadable)?.reload()
                }
            }
        })
    }

    deinit {
        token.invalidate()
    }
}

extension DataBaseService: DataBaseProvider {

    func addObserver(_ observer: Reloadable) {
        observers.add(observer)
    }

    func removeObserver(_ observer: Reloadable) {
        observers.remove(observer)
    }

    func getAllAnswers() -> [Answer] {
        var result = [Answer]()

        let answers = realm.objects(ObjectAnswer.self).sorted(byKeyPath: #keyPath(ObjectAnswer.date), ascending: false)

        answers.forEach { objectAnswerFromDB in
            let answer = Answer.fromObjectAnswer(objectAnswerFromDB)

            result.append(answer)
        }

        return result
    }

    func save(answer: Answer) {
        let objectAnswer = answer.toObjectAnswer()

        DispatchQueue(label: "background").async {
            do {
                let backgroundRealm = try Realm()
                try backgroundRealm.write {
                        backgroundRealm.add(objectAnswer, update: .all)
                    }
            } catch {
                fatalError()
            }
        }
    }

    func remove(by identifier: String) {
        let objectToDelete = realm.objects(ObjectAnswer.self).filter("identifier=%@", identifier)

        do {
            try realm.write {
                realm.delete(objectToDelete)
            }
        } catch {
            fatalError()
        }
    }
}
