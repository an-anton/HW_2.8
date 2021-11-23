//
//  Developers.swift
//  HW_2.8
//
//  Created by Anton Anan'eV on 23.11.2021.
//

struct Developer {
    let fullName: String
    let descriprions: String
    let avatar: String
    
    static func getDev() -> [Developer] {
        [Developer(fullName: "Ананьев Антон", descriprions: "всем привет! Это приложение как домашнее задание к восьмому уроку. Мы с коллегой являемся разработчиками данного приложения. Строго не судите, ведь мы только учимся😊", avatar: "AntonAvatar"),
        Developer(fullName: "Походин Илья", descriprions: "Cтыд и позор мира разработки 😂 за то что такое корявое приложение написали", avatar: "IlyaAvatar")]
    }
}
