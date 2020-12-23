import SwiftUI
import PlaygroundSupport
import SQLite


var str = "Hello, playground"

let path = NSSearchPathForDirectoriesInDomains(
    .documentDirectory, .userDomainMask, true
).first!
"""
print("\(path)")
do{
    let db = try Connection("\(path)/db.sqlite3")
    let id = Expression<Int64>("id")
    let email = Expression<String>("email")
    let name = Expression<String?>("name")
    let users = Table("users")
}catch{
    
}
"""
