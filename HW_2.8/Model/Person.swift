//
//  Person.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

struct Person {
    var name: String
    var accountList: [AccountList]
    var transaction: [Transaction]
}

struct AccountList {
    var accountName: String
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

extension Person {
    static func getPerson() -> Person {
        
        Person(name: "ilya",
               accountList: [
                AccountList(
                    accountName: "Карта Тинькофф",
                    accountStartCount: 1000
                ),
                AccountList(
                    accountName: "Карта ВТБ",
                    accountStartCount: 2000
                ),
                AccountList(
                    accountName: "Карта Сбербанка",
                    accountStartCount: 5000
                )
               ],
               transaction: [
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
