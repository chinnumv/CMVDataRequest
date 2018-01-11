//
//  CMVDataRequest.swift
//  CMVDataRequest
//
//  Created by Chinnu M V on 1/11/18.
//

import UIKit
enum ReturnType {
    case array
    case dictionary
    
}

class CMVDataRequest: NSObject {
    
    
    
    
    // GET method
    
    
    func dataRequest_GET(urlString : String, paramters : NSDictionary?,returnType:ReturnType, callback:@escaping (Any) -> Void){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                
                var posts : Any
                
                if returnType == .array {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray
                    posts = json
                }
                else{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    posts = json
                }
                callback(posts)
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    
    
    
    
    // POST method
    
    func dataRequest_POST(urlString : String ,paramters : NSDictionary?, returnType:ReturnType,callback:@escaping (Any) -> Void){
        
        
        let url = URL(string:  urlString )! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            
            if paramters == nil {
                //request.httpBody = try JSONSerialization.data(withJSONObject: paramters!, options: .prettyPrinted)
            }
            else{
                request.httpBody = try JSONSerialization.data(withJSONObject: paramters!, options: .prettyPrinted)
            }
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    
                }
                print(error?.localizedDescription as Any)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    
                }
                return
            }
            
            do {
                
                var posts : Any = ""
                
                if returnType == .array {
                    
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray {
                        posts = json
                    }
                    
                }
                else
                {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                        
                        posts = json
                    }
                }
                callback(posts)
                
            }
                
                
                
            catch let error {
                DispatchQueue.main.async {
                    
                }
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
    }
    
    
    
    
    // MARK: - Gets data in Dictionary format
    // PUT method
    
    
    func dataRequest_PUT(urlString : String ,paramters : NSDictionary?,callback:@escaping (NSDictionary) -> Void){
        
        print(paramters);
        
        //create the url with URL
        let url = URL(string:  urlString )! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "PUT" //set http method as POST
        
        do {
            
            if paramters == nil {
                //request.httpBody = try JSONSerialization.data(withJSONObject: paramters!, options: .prettyPrinted)
            }
            else{
                request.httpBody = try JSONSerialization.data(withJSONObject: paramters!, options: .prettyPrinted)
            }
            // pass dictionary to nsdata object and set it as request body
            
            //  print( request.httpBody!)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    
                }
                print(error?.localizedDescription as Any)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    
                }
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                    //  print(json)
                    let posts = json
                    callback(posts)
                    
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    
                }
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
    }
}
