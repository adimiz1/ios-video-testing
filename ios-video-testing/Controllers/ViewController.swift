//
//  ViewController.swift
//  ios-video-testing
//
//  Created by Adi Mizrahi on 02/11/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tvMain: UITableView!
    var tableControler: VideoTableController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainTable()
    }

    func setMainTable() {
        tableControler = VideoTableController()
        tvMain.delegate = tableControler
        tvMain.dataSource = tableControler
    }


}

