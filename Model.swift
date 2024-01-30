import Foundation

struct CoinResponse: Codable {
    let success: Bool
    let pagination: Pagination
    let data: [Coin]
}

// "data" 配列内の各アイテムに対応するモデル
struct Coin: Codable, Identifiable{
    let id: Int
    let amount: String
    let rate: String
    let pair: String
    let orderType: String
    let createdAt: String
//
    var formattedDateString: String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // ISO 8601 形式
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTCを指定

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd\nHH:mm:ss" // 出力形式

        if let date = inputFormatter.date(from: createdAt) {
            return outputFormatter.string(from: date) // Dateを指定したフォーマットのStringに変換
        } else {
            return nil // 日付の変換に失敗した場合
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case amount
        case rate
        case pair
        case orderType = "order_type"
        case createdAt = "created_at"
    }
}

// "pagination" オブジェクトに対応するモデル
struct Pagination: Codable {
    let limit: Int
    let order: String
    let startingAfter: String?
    let endingBefore: String?

    private enum CodingKeys: String, CodingKey {
        case limit
        case order
        case startingAfter = "starting_after"
        case endingBefore = "ending_before"
    }
}

//{
//  "success": true,
//  "pagination": {
//    "limit": 1,
//    "order": "desc",
//    "starting_after": null,
//    "ending_before": null
//  },
//  "data": [
//    {
//      "id": 82,
//      "amount": "0.28391",
//      "rate": "35400.0",
//      "pair": "btc_jpy",
//      "order_type": "sell",
//      "created_at": "2015-01-10T05:55:38.000Z"
//    },
//    {
//      "id": 81,
//      "amount": "0.1",
//      "rate": "36120.0",
//      "pair": "btc_jpy",
//      "order_type": "buy",
//      "created_at": "2015-01-09T15:25:13.000Z"
//    }
//  ]
//}
