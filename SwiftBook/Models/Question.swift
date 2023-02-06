//
//  Question.swift
//  SwiftBook
//
//  Created by Yuri on 11.01.2023.
//

//Передать массив с ответами на экран с результатами
//Определить наиболее часто встречающийся тип животного
//Отобразить результаты в соотвствии с этим животным
//Избавиться от кнопки возврата назад на экране результатов

struct Question {
    let title: String
    let responseType: ResponseType
    let answers: [Answer]
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            return "Вам нравится всё мягкое. Вы здоровы и полны энергии."
        default:
            return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на большой дистанции."
        }
    }
}

extension Question {
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Какую пищу предпочитаете?",
                responseType: .single,
                answers: [
                    Answer(title: "Стейк", type: .dog),
                    Answer(title: "Рыба", type: .cat),
                    Answer(title: "Морковь", type: .rabbit),
                    Answer(title: "Кукуруза", type: .turtle)
                ]
            ),
            Question(
                title: "Что вам нравитс больше?",
                responseType: .multiple,
                answers: [
                    Answer(title: "Плавать", type: .dog),
                    Answer(title: "Спать", type: .cat),
                    Answer(title: "Обниматься", type: .rabbit),
                    Answer(title: "Есть", type: .turtle)
                ]
            ),
            Question(
                title: "Любите ли вы поезки на машине?",
                responseType: .ranged,
                answers: [
                    Answer(title: "Обожаю", type: .dog),
                    Answer(title: "Ненавижу", type: .cat),
                    Answer(title: "Нервничаю", type: .rabbit),
                    Answer(title: "Не замечаю", type: .turtle)
                ]
            )
        ]
    }
    
}
