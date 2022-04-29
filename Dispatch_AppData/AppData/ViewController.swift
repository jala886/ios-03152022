import UIKit

class ViewController: UIViewController {

    @IBAction func execute() {
        executeTest()
    }
    
    func executeTest() {
        let count = 100
        
        for index in 0..<count {
            AppData.shared.set(value: index, key: String(index))
        }
        
        DispatchQueue.concurrentPerform(iterations:count) { (index) in
            if let n = AppData.shared.object(key: String(index)) as? Int{
                print(n)
            }
        }
        
        AppData.shared.reset()
        // solved 1
        DispatchQueue.concurrentPerform(iterations:count) { (index) in
            DispatchQueue.main.async {
                AppData.shared.set(value:index,key:String(index))
            }
            
        }
        AppData.shared.reset()
        // solved 2
        let lock = NSLock()
        DispatchQueue.concurrentPerform(iterations:count) { (index) in
            lock.lock()
                AppData.shared.set(value:index,key:String(index))
            lock.unlock()
            
        }
    }
}

