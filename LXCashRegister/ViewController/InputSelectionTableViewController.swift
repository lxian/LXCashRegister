//
//  InputSelectionTableViewController.swift
//  LXCashRegister
//
//  Created by XianLi on 10/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class InputSelectionTableViewController: UITableViewController {
    enum InputFileType: Int {
        case SampleInputNoDiscountFileName = 0
        case SampleInputOffPercentFileName
        case SampleInputBuyTwoGetOneFileName
        case SampleInputBothDiscountFileName
        
        func displayFileName() -> String {
            switch(self) {
            case .SampleInputNoDiscountFileName:
                return "无折扣"
            case .SampleInputOffPercentFileName:
                return "95折"
            case .SampleInputBuyTwoGetOneFileName:
                return "买二送一"
            case .SampleInputBothDiscountFileName:
                return "两种折扣均有"
            }
        }
        
        func fileName() -> String {
            switch(self) {
            case .SampleInputNoDiscountFileName:
                return "SampleInputNoDiscount"
            case .SampleInputOffPercentFileName:
                return "SampleInputOffPercent"
            case .SampleInputBuyTwoGetOneFileName:
                return "SampleInputBuyTwoGetOne"
            case .SampleInputBothDiscountFileName:
                return "SampleInputBothDiscount"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "InputSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: InputSelectionTableViewCell.preferredReuseIdent)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return InputSelectionTableViewCell.preferredHeight
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(InputSelectionTableViewCell.preferredReuseIdent, forIndexPath: indexPath) as! InputSelectionTableViewCell
        
        if let inputFileType = InputFileType(rawValue: indexPath.row) {
            cell.inputFileNameLabel.text = inputFileType.displayFileName()
            cell.accessoryType = .DisclosureIndicator
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("inputSelectionTableShowOutputViewSegue", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inputSelectionTableShowOutputViewSegue" {
            guard let indexPath = sender as? NSIndexPath,
                let outputVC = segue.destinationViewController as? OutputViewController,
                let inputFileName = InputFileType(rawValue: indexPath.row)?.fileName()
                else { return }
            
            let input = InputConverter.readFromFile(inputFileName)
            let purchases = Purchase.createPurchaseArray(input)
            outputVC.outputString = FullStatement.outputString(purchases)
        }
    }
}
