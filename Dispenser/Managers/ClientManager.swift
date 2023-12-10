//
//  ClientManager.swift
//  Dispenser
//
//  Created by Wagner Duarte on 07/12/23.
//

import Foundation

class ClientManager {
    
    enum APIErrors: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
    func getRemedyList() async throws -> [Remedy] {
        
        let endpoint = "https://dosador-de-remedios.onrender.com/remedies"
        
        guard let url = URL(string: endpoint) else {
            print("URL")
            throw APIErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("RESPONSE")
            throw APIErrors.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Remedy].self, from: data)
        } catch {
            print("DATA")
            throw APIErrors.invalidData
        }
        
    }
    
    func getRemedy(id: Int) async throws -> Remedy {
        
        let endpoint = "https://dosador-de-remedios.onrender.com/remedies/\(id)"
        
        guard let url = URL(string: endpoint) else {
            print("URL")
            throw APIErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("RESPONSE")
            throw APIErrors.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Remedy.self, from: data)
        } catch {
            print("DATA")
            throw APIErrors.invalidData
        }
        
    }
    
    func postNewRemedy(remedy: Remedy){
        
        guard let url = URL(string: "https://dosador-de-remedios.onrender.com/remedies") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let theBody: [String: AnyHashable] = [
            "name": remedy.name,
            "frequency": remedy.frequency,
            "amount_per_dose": remedy.amountPerDose,
            "notes": remedy.notes,
            "tube_identifier": remedy.tubeIdentifier,
            "remaining_doses": remedy.remainingDoses,
            "last_dose": remedy.lastDose
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: theBody, options: .fragmentsAllowed)
                
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("SUCCESS: \(response)")
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let remedyID = try decoder.decode(Remedy.self, from: data)
                remedy.id = remedyID.id
                print(remedy.id)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func deleteRemedy(id: Int){
        guard let url = URL(string: "https://dosador-de-remedios.onrender.com/remedies/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("SUCCESS: \(response)")
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func putRemedy(remedy: Remedy) async throws {
        
        print(remedy.id)
        
        let endpoint = "https://dosador-de-remedios.onrender.com/remedies/\(remedy.id)"
        
        guard let url = URL(string: endpoint) else {
            print("URL")
            throw APIErrors.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let theBody: [String: AnyHashable] = [
            "name": remedy.name,
            "frequency": remedy.frequency,
            "amount_per_dose": remedy.amountPerDose,
            "notes": remedy.notes,
            "tube_identifier": remedy.tubeIdentifier,
            "remaining_doses": remedy.remainingDoses,
            "last_dose": remedy.lastDose
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: theBody, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("SUCCESS: \(response)")
            } catch {
                print(error)
            }
            
        }
        task.resume()
        
    }
    
}
