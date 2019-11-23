//
//  RecentSearchesViewController.swift
//  weather-app
//
//  Created Ming Chu on 22/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class RecentSearchesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView?

    @IBAction func closeButtonDidPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    var presenter: RecentSearchesPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInterface()

        self.presenter?.requestFetchSearchHistory()
    }

    private func setupInterface() {
        self.tableView?.register(cell: .searchRecordTableViewCell)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
}

extension RecentSearchesViewController: RecentSearchesViewProtocol {
    func updateSearchHistory(records: [SearchRecord]) {
        self.tableView?.reloadData()
    }
}

extension RecentSearchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.searchRecords.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let record = self.presenter?.searchRecords[indexPath.row] else { return UITableViewCell() }
        let viewModel = SearchRecordViewModel(searchRecord: record)
        if let cell = tableView.dequeueReusableCell(withIdentifier: AppCell.searchRecordTableViewCell.reuseIdentifier) as? SearchRecordTableViewCell {
            cell.setupCell(viewModel: viewModel, delegate: self)
            return cell
        }
        return UITableViewCell()
    }
}

extension RecentSearchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension RecentSearchesViewController: SearchRecordTableViewCellDelegate {
    func requestDeleteRecord(recordId: String) {
        self.presenter?.requestRemoveSearchRecord(recordId: recordId)
    }

    func requestPerformSearch(recordId: String) {
        self.presenter?.requestPerformSearch(recordId: recordId)
    }
}
