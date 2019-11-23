//
//  SearchRecordTableViewCell.swift
//  weather-app
//
//  Created by Ming Chu on 23/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import UIKit

protocol SearchRecordTableViewCellViewModel {
    var recordId: String { get }
    var queryDetails: String { get }
    var datetime: String { get }
}

protocol SearchRecordTableViewCellDelegate {
    func requestDeleteRecord(recordId: String)
    func requestPerformSearch(recordId: String)
}

class SearchRecordTableViewCell: UITableViewCell {

    @IBOutlet private weak var queryDetailsLabel: UILabel?
    @IBOutlet private weak var datetimeLabel: UILabel?

    @IBAction func deleteButtonDidPressed(_ sender: Any) {
        guard let recordId = self.recordId else { return }
        self.delegate?.requestDeleteRecord(recordId: recordId)
    }

    @IBAction func searchButtonDidPressed(_ sender: Any) {
        guard let recordId = self.recordId else { return }
        self.delegate?.requestPerformSearch(recordId: recordId)
    }

    private var recordId: String?
    private var delegate: SearchRecordTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.recordId = nil
        self.queryDetailsLabel?.text = nil
        self.datetimeLabel?.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(viewModel: SearchRecordTableViewCellViewModel, delegate: SearchRecordTableViewCellDelegate?) {
        self.delegate = delegate
        self.recordId = viewModel.recordId
        self.queryDetailsLabel?.text = viewModel.queryDetails
        self.datetimeLabel?.text = viewModel.datetime
    }
}
