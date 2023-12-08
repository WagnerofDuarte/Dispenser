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
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}

/*curl -X POST https://dosador-de-remedios.onrender.com/remedies
     -H 'Content-Type: application/json'
     -d '{"id": 10,"name": "TESTE","frequency": 1,"amount_per_dose": 1,"last_dose": "2023-11-28T15:12:00.000Z","remaining_doses": 2,"notes": "AAASSSASASASSASA","tube_identifier": 1}'*/
