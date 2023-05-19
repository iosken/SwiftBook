//
//  Wallstreetbet.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct Wallstreetbet: Decodable {
    let no_of_comments: Int?
    let sentiment: String?
    let sentiment_score: Double?
    let ticker: String?
}


//SOURCE:
//https://tradestie.com/api/v1/apps/reddit
/*[{"no_of_comments":45,
    "sentiment":"Bullish",
    "sentiment_score":0.084,
    "ticker":"AI"},
 {"no_of_comments":7,
    "sentiment":"Bearish",
    "sentiment_score":-0.067,"ticker":"QQQ"},
 {"no_of_comments":6,
    "sentiment":"Bullish",
    "sentiment_score":0.353,"ticker":"BBBY"},
 {"no_of_comments":5,
    "sentiment":"Bullish",
    "sentiment_score":0.062,"ticker":"PACW"},
 {"no_of_comments":5,
    "sentiment":"Bearish",
    "sentiment_score":-0.099,"ticker":"FRC"},
 {"no_of_comments":5,"sentiment":"Bearish","sentiment_score":-0.164,"ticker":"MAN"},{"no_of_comments":4,"sentiment":"Bullish","sentiment_score":0.144,"ticker":"TV"},{"no_of_comments":4,"sentiment":"Bearish","sentiment_score":-0.26,"ticker":"AAPL"},{"no_of_comments":3,"sentiment":"Bearish","sentiment_score":-0.25,"ticker":"ON"},{"no_of_comments":3,"sentiment":"Bearish","sentiment_score":-0.29,"ticker":"TSLA"},{"no_of_comments":3,"sentiment":"Bearish","sentiment_score":-0.024,"ticker":"IQ"},{"no_of_comments":3,"sentiment":"Bearish","sentiment_score":-0.23,"ticker":"NVDA"},{"no_of_comments":3,"sentiment":"Bearish","sentiment_score":-0.179,"ticker":"BOE"},{"no_of_comments":2,"sentiment":"Bearish","sentiment_score":-0.779,"ticker":"SPR"},{"no_of_comments":2,"sentiment":"Bullish","sentiment_score":0.125,"ticker":"JD"},{"no_of_comments":2,"sentiment":"Bullish","sentiment_score":0.159,"ticker":"SQQQ"},{"no_of_comments":2,"sentiment":"Bullish","sentiment_score":0.159,"ticker":"PLTR"},{"no_of_comments":2,"sentiment":"Bearish","sentiment_score":-0.651,"ticker":"PYPL"},{"no_of_comments":2,"sentiment":"Bearish","sentiment_score":-0.051,"ticker":"AMD"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.8,"ticker":"MEN"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"TA"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.34,"ticker":"MSFT"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.178,"ticker":"HAS"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"RSI"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.414,"ticker":"HDB"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"HD"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.826,"ticker":"GOOGL"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.924,"ticker":"BRO"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.318,"ticker":"ALOT"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"NIM"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.784,"ticker":"WF"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.326,"ticker":"LL"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.702,"ticker":"VERY"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.151,"ticker":"OPEN"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.938,"ticker":"TM"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"LIFE"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.402,"ticker":"AMZN"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.103,"ticker":"AVGO"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"WEN"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.572,"ticker":"SA"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.273,"ticker":"CHGG"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"BEN"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.174,"ticker":"ES"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.013,"ticker":"BABA"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"KBWB"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.052,"ticker":"EV"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"MC"},{"no_of_comments":1,"sentiment":"Bullish","sentiment_score":0.242,"ticker":"USB"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":0.0,"ticker":"BY"},{"no_of_comments":1,"sentiment":"Bearish","sentiment_score":-0.644,"ticker":"CB"}]
*/
