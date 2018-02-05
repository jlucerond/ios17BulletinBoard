//
//  MainTableViewController.swift
//  ios17BulletinBoard
//
//  Created by Joe Lucero on 2/5/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
   
   @IBOutlet weak var messageTextField: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // listen for a message, and act accordingly
   }
   
   // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return MessageController.shared.messages.count
   }
   
   @IBAction func postButtonPressed(_ sender: UIButton) {
      guard let text = messageTextField.text, !text.isEmpty else { return }
      MessageController.shared.saveNewMessageWith(text: text)
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
      
      let message = MessageController.shared.messages[indexPath.row]
      cell.textLabel?.text = message.text
      cell.detailTextLabel?.text = message.date.description
      
      
      return cell
   }
   
   
   
}
