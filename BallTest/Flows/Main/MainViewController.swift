//
//  MainViewController.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

private let transformAnimationKey = "transform"

final class MainViewController: UIViewController {

    private let questionTextField = UITextField()
    private let answerLabel = UILabel()
    private let eventsCountLabel = UILabel()
    private let answerView = UIView()
    private let animationView = UIView()

    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel

    private var isAnimationNeeded = false

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupControls()
        setupBindings()
        tabBarItem = UITabBarItem(title: L10n.mainTitle,
                                  image: Asset.icnQuestion.image,
                                  selectedImage: Asset.icnQuestion.image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = L10n.mainTitle
        view.backgroundColor = Asset.Colors.light.color
        navigationController?.navigationBar.barTintColor = Asset.Colors.light.color
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

        guard motion == .motionShake else { return }
        viewModel.incrementCounter()
        view.endEditing(true)

        guard let question = questionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !question.isEmpty else {
            showAlert(title: L10n.alertCommonTitle, message: L10n.mainAlertQuestionMessage)
            return
        }
        answerLabel.text = ""
        startAnimation()

        viewModel.getAnswer(to: question)
    }

    private func setupControls() {
        setupQuestionViews()
        setupAnswerView()
    }

    private func setupQuestionViews() {
        let questionTitleLabel = UILabel()
        questionTextField.delegate = self

        view.addSubview(eventsCountLabel)
        view.addSubview(questionTitleLabel)
        view.addSubview(questionTextField)
        view.addSubview(answerView)

        eventsCountLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(100)
            make.bottom.equalTo(questionTitleLabel.snp.top).offset(-20)
        }
        eventsCountLabel.textAlignment = .left

        questionTitleLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(questionTextField.snp.top).offset(-20)
        }
        questionTitleLabel.numberOfLines = 0
        questionTitleLabel.text = L10n.mainQuestionTitle
        questionTitleLabel.textAlignment = .center

        questionTextField.snp.makeConstraints { make -> Void in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(answerView.snp.top).offset(-20)
        }
        questionTextField.placeholder = L10n.mainQuestionPlaceholder
        questionTextField.borderStyle = .roundedRect
    }

    private func setupAnswerView() {
        answerView.snp.makeConstraints { make -> Void in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-30)
        }

        answerView.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
        }
        animationView.backgroundColor = Asset.Colors.dark.color
        animationView.layer.cornerRadius = 100

        animationView.addSubview(answerLabel)
        answerLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.centerY.equalToSuperview()
        }
        answerLabel.numberOfLines = 0
        answerLabel.textColor = Asset.Colors.light.color
        answerLabel.textAlignment = .center
    }

    private func setupBindings() {
        viewModel.answerUpdated
            .subscribe(onNext: { [weak self] presentableAnswer in
                self?.isAnimationNeeded = false
                self?.answerLabel.text = presentableAnswer.text
            })
            .disposed(by: disposeBag)

        viewModel.isErrorAlertNeeded
            .subscribe(onNext: { [weak self] isErrorAlertNeeded in
                guard isErrorAlertNeeded else { return }
                self?.showAlert(title: L10n.alertCommonTitle, message:
                    L10n.mainAlertAnswerMessage)
                self?.isAnimationNeeded = false
            })
            .disposed(by: disposeBag)

        viewModel.eventCountUpdated
            .subscribe(onNext: { [weak self] countString in
                self?.eventsCountLabel.text = countString
            })
            .disposed(by: disposeBag)
    }

    private func startAnimation() {
        isAnimationNeeded = true
        addAnimation()
    }

    private func addAnimation() {
        let layer = animationView.layer

        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: transformAnimationKey)
        animation.toValue = CATransform3DMakeRotation(CGFloat.pi, 1.0, 1.0, 1.0)
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = 0.4
        animation.isCumulative = true
        animation.repeatCount = 2

        CATransaction.setCompletionBlock { [weak self] in
            layer.removeAllAnimations()
            if self?.isAnimationNeeded == true {
                self?.addAnimation()
            }
          }

         layer.add(animation, forKey: transformAnimationKey)

         CATransaction.commit()
    }
}

extension MainViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}

extension MainViewController: Alertable { }
