//
//  LoginViewController.swift
//  MeetingApp
//
//  Created by Troels on 24/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let userDTO = UserDTO()
        
        userDTO.userid = user.text
        userDTO.password = password.text
        
        let jsonData = try! JSONEncoder().encode(userDTO)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        
        //printMyStarredGistsWithBasicAuth()

 
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func getHeaders() -> [String: String] {
        let userName = "test"
        let password = "test"
        let credentialData = "\(userName):\(password)".data(using: .utf8)
        guard let cred = credentialData else { return ["" : ""] }
        let base64Credentials = cred.base64EncodedData(options: [])
        guard let base64Date = Data(base64Encoded: base64Credentials) else { return ["" : ""] }
        return ["Authorization": "Basic \(base64Date.base64EncodedString())"]
    }
    
    func printMyStarredGistsWithBasicAuth() -> Void {
        let user = "test"
        let password = "test"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJGZWVkYmFjayIsInVzZXIiOnsidXNlcklkIjotMSwidXNlck5hbWUiOiJ0ZXN0IiwicGFzc3dvcmQiOiIifSwiZXhwIjoxNTUzNDYzODg0fQ.jhZboldT3inNw9kegYPSCmyzOk9-BcZif5NpB73jU0Fo69G-dOqPqlX1Avcmui6KEegAA7ab6SRm9CzZtG8_Og"
        }
        
        Alamofire.request("http://localhost:8080/rest/login", method: .post, headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
        
        
        

}
    
}

final class JWTAccessTokenAdapter: RequestAdapter {
    typealias JWT = String
    private let accessToken: JWT
    
    init(accessToken: JWT) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("http://localhost:8080/rest/login") {
            /// Set the Authorization header value using the access token.
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}

