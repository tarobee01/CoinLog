//
//  Services.swift
//  NetworkingPractice
//
//  Created by 武林慎太郎 on 2024/01/28.
//

import Foundation

class Services {
    
    func fetchCoins(pair: String) async -> [Coin]{
        let fetchCoinsUrlString = "https://coincheck.com/api/trades?pair=\(pair)"
        //ウラルオブジェクトに変換
        guard let url = URL(string: fetchCoinsUrlString) else {
            print("debug: invalid url")
            return []
        }
        //ウラルからデータを取得
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            //モデルを元にしてデコード
            let decodedObject = try JSONDecoder().decode(CoinResponse.self, from: data)
            
            //オブジェクトの特定部分を返す
            print(decodedObject.data)
            let coins = decodedObject.data
            return coins
        } catch {
            print("debug: error occured \(error.localizedDescription)")
            return []
        }
    }

    
    func fetchPing(completion: @escaping(String) -> Void) {
        let fetchPingUrlString = "https://api.coingecko.com/api/v3/ping"
        guard let url = URL(string: fetchPingUrlString) else {
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("something went wrong\(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("invalid data")
                return
            }
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) else {
                print("failed to jsonserialization")
                return
            }
            print(jsonObject)
            
            guard let castedJsonObject = jsonObject as? [String: String] else {
                print("cast failed")
                return
            }
            print(castedJsonObject)
            
            
            guard let ping = castedJsonObject["gecko_says"] else {
                print("failed to reference dictionary key")
                return
            }
            
            print(ping)
            completion(ping)
        }.resume()
    }
}
