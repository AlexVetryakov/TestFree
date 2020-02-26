//
//  SettingsViewController.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

final class SettingsViewController: UIViewController {

    private let tableView = UITableView()
    private let viewModel: SettingsViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupLayouts()
        tabBarItem = UITabBarItem(title: L10n.settingsTitle,
                                  image: Asset.icnSettings.image,
                                  selectedImage: Asset.icnSettings.image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = L10n.settingsTitle

        navigationItem.rightBarButtonItem =
            addNavigationItem(target: self, action: #selector(addButtonTapped))
        navigationController?.navigationBar.barTintColor = Asset.Colors.light.color

        setupTableView()
        reloadData()
    }

    private func reloadData() {
        viewModel.getAnswers()
    }

    private func addNavigationItem(target: UIViewController,
                                   action: Selector) -> UIBarButtonItem {
        let backgroundImage = Asset.icnAdd.image
        let button = UIButton(type: .system)
        button.setImage(backgroundImage, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.contentHorizontalAlignment = .center
        button.tintColor = Asset.Colors.dark.color
        button.addTarget(target, action: action, for: .touchUpInside)

        return UIBarButtonItem(customView: button)
    }

    private func setupLayouts() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make -> Void in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.register(cellType: SettingsCell.self)
        tableView.rowHeight = 45

        let dataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, PresentableAnswer>>(
            configureCell: { (_, tableView, indexPath, presentableAnswer) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(for: indexPath) as SettingsCell
                cell.configure(with: presentableAnswer)
                return cell
            }
        )
        dataSource.canEditRowAtIndexPath = { _, _ in true }

        viewModel.dataSourceUpdated
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.itemDeleted
            .bind { [weak self] indexPath in
                self?.viewModel.removeAnswer(at: indexPath.row)
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Actions

    @objc private func addButtonTapped() {
        showAlertWthTextField(title: "", message: L10n.settingsAlertEventMessage) { text in
            guard let answerText = text?.trimmingCharacters(in: .whitespacesAndNewlines), !answerText.isEmpty else {
                self.showAlert(title: L10n.alertCommonTitle, message: L10n.settingsAlertMessage)
                return
            }
            self.viewModel.addAnswer(with: answerText)
        }
    }
}

extension SettingsViewController: Alertable { }
