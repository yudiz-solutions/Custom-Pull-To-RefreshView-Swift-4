//
//  ViewController.swift
//  CustomRefreshControl
//
//  Created by Yudiz on 18/04/18.
//  Copyright © 2018 Yudiz. All rights reserved.
//

import UIKit

/// TableCell
class TableCell: UITableViewCell {
    
    /// IBOutlet
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
}

/// ViewController
class ViewController: UIViewController {

    /// IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    /// Variable Declaration
    var refreshView: RefreshView!
    
    var tableViewRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refreshControl
    }()
    
    /// View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Preparing the user interface
        prepareUI()
    }
}

// MARK: - UI Related
extension ViewController {
    
    func prepareUI() {
        // Adding 'tableViewRefreshControl' to tableView
        tableView.refreshControl = tableViewRefreshControl
        // Getting the nib from bundle
        getRefereshView()
    }
    
    func getRefereshView() {
        if let objOfRefreshView = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)?.first as? RefreshView {
            // Initializing the 'refreshView'
            refreshView = objOfRefreshView
            // Giving the frame as per 'tableViewRefreshControl'
            refreshView.frame = tableViewRefreshControl.frame
            // Adding the 'refreshView' to 'tableViewRefreshControl'
            tableViewRefreshControl.addSubview(refreshView)
        }
    }
}

// MARK: - Other Methods
extension ViewController {
 
    @objc func refreshTableView() {
        refreshView.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.refreshView.stopAnimation()
            self.tableViewRefreshControl.endRefreshing()
        }
    }
}

// MARK: - UITableView Delegate and DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
