//
//  Message.swift
//  ios17BulletinBoard
//
//  Created by Joe Lucero on 2/5/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation
import CloudKit

struct Message {
   let text: String
   let date: Date
   let cloudKitID: CKRecordID?
   
   // Saving: make into a ckRecord (computed property)
   var asCKRecord: CKRecord {
      let record: CKRecord
      if cloudKitID == nil {
         record = CKRecord(recordType: CloudKitKeys.type)
      } else {
         record = CKRecord(recordType: CloudKitKeys.type, recordID: cloudKitID!)
      }
      
      record.setObject(text as CKRecordValue, forKey: CloudKitKeys.text)
      record.setObject(date as CKRecordValue, forKey: CloudKitKeys.date)
      
      return record
   }
   
   // Create: locally (member-wise init)
   init(text: String) {
      self.text = text
      self.date = Date()
      self.cloudKitID = nil
   }
   
   // Create: from CloudKit Record (json-esque failable init)
   init?(record: CKRecord) {
      guard let text = record.object(forKey: CloudKitKeys.text) as? String,
         let date = record.object(forKey: CloudKitKeys.date) as? Date else { return nil }
      
      self.text = text
      self.date = date
      self.cloudKitID = record.recordID
      
   }
   
}










