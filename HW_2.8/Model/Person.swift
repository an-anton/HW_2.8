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
    let category: String
    let typeTransaction: String // тип (доход, расход, перевод)
    let accountTransactionFrom: String // с какого счёта было списание
    let accountTransactionTo: String // если тип "перевод", то на какой счёт был перевод
}

enum AccountTypes: String {
    case card = "Карта"
    case cash = "Наличные"
}

extension Person {
    static func getPerson() -> Person {
        
        Person(name: "ilya",
               accountTypes: [.card, .cash],
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
                    amountTransaction: 2000, category: "Мебель",
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
                    amountTransaction: 1000, category: "Бензин",
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
                    amountTransaction: 5000, category: "Машина",
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
                    amountTransaction: 10000, category: "Проект",
                    typeTransaction: "Доход",
                    accountTransactionFrom: "Карта ВТБ",
                    accountTransactionTo: ""
                )
               ]
        )
        
    }
}
