//
//  StatementsViewController.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation
import UIKit
import Networking
import Extensions

protocol StatementsViewControllerDisplay: AnyObject {
    func showSkeleton()
    func hideSkeleton()
    func reloadTable()
    func setFilterToAll()
    func showErrorAlert()
}

public final class StatementsViewController: UIViewController {
    var viewModel: StatementsViewModeling
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        return control
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.sectionFooterHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.backgroundColor = .white
        table.refreshControl = refreshControl
        
        return table
    }()
    
    private lazy var filterView: StatementFilterView = {
        let filter = StatementFilterView()
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.delegate = self
        
        return filter
    }()
    
    private let skeletonView: StatementsSkeleton = {
        let skeleton = StatementsSkeleton()
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        
        return skeleton
    }()
    
    public init(viewModel: StatementsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        buildLayout()
        
        Task {
            await self.viewModel.fetchStatements()
        }
    }
    
    func setupView() {
        self.navigationItem.hidesBackButton = true
        self.title = "Extrato"
        self.view.backgroundColor = .white
        tableView.register(StatementCell.self, forCellReuseIdentifier: StatementCell.identifier)
        
        let rightButton = UIBarButtonItem(image: .downloadIcon, style: .plain, target: self, action: #selector(downloadStatements))
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupHierarchy() {
        view.addSubview(filterView)
        view.addSubview(tableView)
        view.addSubview(skeletonView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterView.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            skeletonView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            skeletonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func buildLayout() {
        setupView()
        setupHierarchy()
        setupConstraints()
    }
    
    @objc func refreshData() {
        Task {
            await viewModel.refreshStatements()
            refreshControl.endRefreshing()
        }
    }
    
    @objc func downloadStatements() {

    }
}

extension StatementsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.presentedStatements?.group[indexPath.section].statements[indexPath.row].id else { return }
        viewModel.openDetails(of: id)
    }
}

extension StatementsViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.presentedStatements?.group.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.presentedStatements?.group[section].statements.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let statement = viewModel.presentedStatements?.group[indexPath.section].statements[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: StatementCell.identifier, for: indexPath) as? StatementCell
        else { return UITableViewCell() }
        
        cell.setup(with: statement)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dateString = viewModel.presentedStatements?.group[section].date else { return nil }
        let sectionHeader = StatementSectionHearderView()
        sectionHeader.setup(with: dateString)
        
        return sectionHeader
    }
}

extension StatementsViewController: StatementFilterViewDelegate {
    public func filter(by entry: BusinessStatementEntry) {
        viewModel.filterStatements(by: entry)
        tableView.reloadData()
    }
    
    public func filterByFuture() {
        // no handler
    }
    
    public func showAll() {
        viewModel.showAllStatements()
        tableView.reloadData()
    }
}

extension StatementsViewController: StatementsViewControllerDisplay {
    func showErrorAlert() {
        DispatchQueue.main.async {
            self.showAlert(title: "Aconteceu um erro", description: "Tente novamente mais tarde")
        }
    }
    
    func showSkeleton() {
        DispatchQueue.main.async {
            self.skeletonView.isHidden = false
            self.tableView.isHidden = true
        }
    }
    
    func hideSkeleton() {
        DispatchQueue.main.async {
            self.skeletonView.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setFilterToAll() {
        DispatchQueue.main.async {
            self.filterView.allOptionTapped()
        }
    }
}
