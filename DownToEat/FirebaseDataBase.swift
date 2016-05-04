import Foundation
import Firebase

// Example
// var firebase = firebaseConnect()
class FirebaseDataBase
{
	class func firebaseConnect() -> Firebase
	{
		let firebase = Firebase(url: "https://grab-a-bite.firebaseio.com/")
    
		firebase.authUser("grababiteinc@gmail.com", password: "iosmobile", withCompletionBlock:
			{ error, authData in if error != nil
				{ print("Connection failed!")
					} else {
						print("Sucessfully connected")
					}
		})
		return firebase
	}
	
	class func currentUser(userID: NSString) -> Firebase
	{
		let firebase = Firebase(url: "https://grab-a-bite.firebaseio.com/")
		let currUser = firebase.childByAppendingPath("users").childByAppendingPath(userID as String)
		
		return currUser
	}
}