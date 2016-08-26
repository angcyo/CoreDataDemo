//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by angcyo on 16/08/26.
//  Copyright © 2016年 angcyo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

	@IBOutlet weak var timeLabel: UILabel!
	static var startTime: Double!

	let app = UIApplication.sharedApplication().delegate as! AppDelegate
	var context: NSManagedObjectContext {
		return self.app.managedObjectContext
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func insert1000(sender: AnyObject) {
		run {
			for index in 0..<1000 {
				let demoEntity = NSEntityDescription.insertNewObjectForEntityForName("DemoEntity", inManagedObjectContext: self.context) as! DemoEntity
				demoEntity.age = 1.2
				demoEntity.password = index
				demoEntity.username = "username:\(index)"
				demoEntity.time = NSDate().timeIntervalSince1970

				if (try? self.context.save()) != nil {
					print("保存成功\(index)")
				} else {
					print("保存失败\(index)")
				}
			}
		}

	}
	@IBAction func insert(sender: AnyObject) {
		run {
			for index in 0..<10000 {
				let demoEntity = NSEntityDescription.insertNewObjectForEntityForName("DemoEntity", inManagedObjectContext: self.context) as! DemoEntity
				demoEntity.age = 1.2
				demoEntity.password = index
				demoEntity.username = "username:\(index)"
				demoEntity.time = NSDate().timeIntervalSince1970

//				if (try? self.context.save()) != nil {
//					print("保存成功\(index)")
//				} else {
//					print("保存失败\(index)")
//				}

				do {
					try self.context.save()
					print("保存成功\(index)")
				} catch {
					print("保存失败\(index)")
				}
			}
		}

	}
	@IBAction func modify(sender: AnyObject) {
		run {
			let fetchRequest = NSFetchRequest()
			fetchRequest.entity = NSEntityDescription.entityForName("DemoEntity", inManagedObjectContext: self.context)
			let demoEntitys = try? self.context.executeFetchRequest(fetchRequest) as! [DemoEntity]
			for (index, demoEntiry) in (demoEntitys?.enumerate())! {
				print("\(NSThread.isMainThread()) 修改: \(index) \(demoEntiry.username)")
				let oldName = demoEntiry.username
				let newName = "angcyo" + demoEntiry.username!
				demoEntiry.username = newName
//				if (try? self.context.save()) != nil {
//					print("修改成功\(index) \(oldName)-->\(newName)")
//				} else {
//					print("修改失败\(index)")
//				}
			}
			if (try? self.context.save()) != nil {
				print("修改成功:\(demoEntitys?.count)条")
			} else {
				print("修改失败\(index)")
			}
		}
	}
	@IBAction func query(sender: AnyObject) {
		run {
			let fetchRequest = NSFetchRequest()
			fetchRequest.entity = NSEntityDescription.entityForName("DemoEntity", inManagedObjectContext: self.context)
			let demoEntitys = try? self.context.executeFetchRequest(fetchRequest) as! [DemoEntity]
//			for (index, demoEntiry) in (demoEntitys?.enumerate())! {
//				print("\(NSThread.isMainThread()) \(index) \(demoEntiry)")
//			}
			print("查询:\(demoEntitys?.count)条")
		}
	}
	@IBAction func del(sender: AnyObject) {
		run {
			let fetchRequest = NSFetchRequest()
			fetchRequest.entity = NSEntityDescription.entityForName("DemoEntity", inManagedObjectContext: self.context)
			let demoEntitys = try? self.context.executeFetchRequest(fetchRequest) as! [DemoEntity]
			for (index, demoEntiry) in (demoEntitys?.enumerate())! {
				print("\(NSThread.isMainThread()) 删除: \(index) \(demoEntiry.username)")
				self.context.deleteObject(demoEntiry)

//				if (try? self.context.save()) != nil {
//					print("删除成功\(index) \(demoEntiry.username)")
//				} else {
//					print("删除失败\(index)")
//				}
			}
			if (try? self.context.save()) != nil {
				print("删除成功:\(demoEntitys?.count)条")
			} else {
				print("删除失败:\(index)")
			}
		}
	}

}

extension ViewController {

	func run(block: () -> ()) {
		NSOperationQueue().addOperationWithBlock {
			self.initTime()
			block()
			self.showTime()
		}
	}

	func initTime() {
		ViewController.startTime = NSDate().timeIntervalSince1970
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
	}

	func showTime() {
		NSOperationQueue.mainQueue().addOperationWithBlock {
			let time = String(format: "%.5f", NSDate().timeIntervalSince1970 - ViewController.startTime)
			let string = "用时:\(time)秒 isMain:\(NSThread.isMainThread())"
			print(string)
			self.timeLabel.text = string
		}
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
	}
}

