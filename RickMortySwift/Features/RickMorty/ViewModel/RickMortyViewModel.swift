//
//  RickMortyViewModel.swift
//  RickMortySwift
//
//  Created by fatih on 29.05.2023.
//

import Foundation

protocol IRickyMortyViewModel {
    func fetchItems()
    func changeLoading()

    var ricyMortyCharacters: [Result] { get set }
    var rickyMortyService: IRickyMortiyeService { get }

    var rickyMortyOutput: RickMortyOutPut? { get }

    func setDelegate(output: RickMortyOutPut)
}

final class RickyMortyViewModel: IRickyMortyViewModel {
    var rickyMortyOutput: RickMortyOutPut?
    
    func setDelegate(output: RickMortyOutPut) {
        rickyMortyOutput = output
    }
    
    var ricyMortyCharacters: [Result] = []
    private var isLoading = false
    let rickyMortyService: IRickyMortiyeService

    init() {
        rickyMortyService = RickyMortyService()
    }

    func fetchItems() {
        changeLoading()
        rickyMortyService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.ricyMortyCharacters = response ?? []
            self?.rickyMortyOutput?.saveDatas(values: self?.ricyMortyCharacters ?? [])
        }
    }

    func changeLoading() {
        isLoading = !isLoading
        rickyMortyOutput?.changeLoading(isLoad: isLoading)
    }
}

