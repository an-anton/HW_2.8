//
//  Person.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

struct Person {
    var login = ""
    var password = ""
    var name: String
    var accountTypes: [AccountTypes]
    var accountСategories: [Categories]
    var accountList: [AccountList]
    var transaction: [Transaction]
}

struct AccountList {
    var accountName: String
    var accountType: AccountTypes
    var accountStartCount: Int
}

struct Transaction {
    let dateTransaction: String // дата
    let amountTransaction: Int // сумма
    let category: String // категория транзакции
    let typeTransaction: String // тип (доход, расход, перевод)
    let accountTransactionFrom: String // с какого счёта было списание
    let accountTransactionTo: String // если тип "перевод", то на какой счёт был перевод
}

enum AccountTypes: String {
    case card = "Карта"
    case cash = "Наличные"
    case bankBill = "Банковкские счета"
}

struct Categories {
    let categoriesName: String
    let categoriesImageName: String
}

extension Person {
    static func getPerson() -> Person {
        
        Person(name: "ilya",
               accountTypes: [.card, .cash, .bankBill],
               accountСategories: [
               Categories(
                categoriesName: "Продукты",
                categoriesImageName: "Продукты"
               ),
               Categories(
                categoriesName: "Транспорт",
                categoriesImageName: "Транспорт"
               ),
               Categories(
                categoriesName: "Развлечения",
                categoriesImageName: "Развлечения"
               ),
               Categories(
                categoriesName: "Одежда и обувь",
                categoriesImageName: "Одежда и обувь"
               ),
               Categories(
                categoriesName: "Автомобиль",
                categoriesImageName: "Автомобиль"
               ),
               Categories(
                categoriesName: "Дом",
                categoriesImageName: "Дом"
               ),
               Categories(
                categoriesName: "Домашние животные",
                categoriesImageName: "Домашние животные"
               ),
               Categories(
                categoriesName: "Дети",
                categoriesImageName: "Дети"
               ),
               Categories(
                categoriesName: "Здоровье",
                categoriesImageName: "Здоровье"
               ),
               Categories(
                categoriesName: "Путешествия",
                categoriesImageName: "Путешествия"
               ),
               Categories(
                categoriesName: "Техника",
                categoriesImageName: "Техника"
               ),
               Categories(
                categoriesName: "Кешбек",
                categoriesImageName: "Кешбек"
               ),
               Categories(
                categoriesName: "Аванс",
                categoriesImageName: "Аванс"
               ),
               Categories(
                categoriesName: "Зарплата",
                categoriesImageName: "Зарплата"
               ),
               Categories(
                categoriesName: "Еда вне дома",
                categoriesImageName: "Еда вне дома"
               )
               ],
               accountList: [
                AccountList(
                    accountName: "Карта Тинькофф",
                    accountType: .card,
                    accountStartCount: 1000
                ),
                AccountList(
                    accountName: "Карта ВТБ",
                    accountType: .card,
                    accountStartCount: 2000
                ),
                AccountList(
                    accountName: "Счёт Сбербанк",
                    accountType: .bankBill,
                    accountStartCount: 2000
                ),
                AccountList(
                    accountName: "Кошелёк",
                    accountType: .cash,
                    accountStartCount: 5000
                )
               ],
               transaction: [
                Transaction(
                    dateTransaction: "21.11.2021",
                    amountTransaction: 1000, category: "Продукты",
                    typeTransaction: "Расход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "20.11.2021",
                    amountTransaction: 1000, category: "Продукты",
                    typeTransaction: "Расход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "17.11.2021",
                    amountTransaction: 5000, category: "Продукты",
                    typeTransaction: "Расход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "17.11.2021",
                    amountTransaction: 2000, category: "Дом",
                    typeTransaction: "Расход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "16.11.2021",
                    amountTransaction: 10000, category: "Кешбек",
                    typeTransaction: "Доход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "15.11.2021",
                    amountTransaction: 5000, category: "Аванс",
                    typeTransaction: "Доход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "10.11.2021",
                    amountTransaction: 1000, category: "Автомобиль",
                    typeTransaction: "Расход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "07.11.2021",
                    amountTransaction: 2000, category: "Одежда",
                    typeTransaction: "Расход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "01.11.2021",
                    amountTransaction: 5000, category: "Автомобиль",
                    typeTransaction: "Расход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "01.11.2021",
                    amountTransaction: 3000, category: "Продукты",
                    typeTransaction: "Расход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "05.11.2021",
                    amountTransaction: 10000, category: "Зарплата",
                    typeTransaction: "Доход",
                    accountTransactionFrom: "Карта Тинькофф",
                    accountTransactionTo: ""
                ),
                Transaction(
                    dateTransaction: "05.11.2021",
                    amountTransaction: 10000, category: "Зарплата",
                    typeTransaction: "Доход",
                    accountTransactionFrom: "Карта ВТБ",
                    accountTransactionTo: ""
                )
               ]
        )
        
    }
}
