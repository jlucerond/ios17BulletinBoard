//
//  MessageController.swift
//  ios17BulletinBoard
//
//  Created by Joe Lucero on 2/5/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation

class MessageController {
   static let shared = MessageController()
   let ckManager = CloudKitManager()
   var messages: [Message] = [] {
      didSet {
         // send out a message
         NotificationCenter.default.post(name: NotificationKeys.messagesUpdated, object: self)
      }
   }
   
   private init() {
      loadMessages()
   }
   
   // save a new message
   func saveNewMessageWith(text: String) {
      let newMessage = Message(text: text)
      ckManager.save(message: newMessage) { (success) in
         if success {
            self.messages.insert(newMessage, at: 0)
         } else {
            // find a way to send a message to VC so user knows there was a problem saving
         }
      }
      
   }
   
   // load all messages
   func loadMessages() {
      ckManager.load { (records, error) in
         if let error = error {
            print("Error querying records from CloudKit: \(error.localizedDescription)")
            return
         }
         
         guard let records = records else { return }
         
         for record in records {
            guard let message = Message(record: record) else { continue }
            self.messages.append(message)
            print("Loaded a message!")
         }
      }
   }
}
