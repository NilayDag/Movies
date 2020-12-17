//
//  MainPresenter.swift
//  Movies
//
//  Created by Eda Nilay DAĞDEMİR on 16.12.2020.
//  Copyright © 2020 Eda Nilay DAĞDEMİR. All rights reserved.
//

import Foundation

class MainPresenter {

    // MARK: Properties
    weak var view: IMainView?
    var router: IMainRouter?
    var interactor: IMainInteractor?
    private var movieList: [Movie] = []
}

extension MainPresenter: IMainPresenter {
    func viewDidLoad() {
        print("here presenter")
        view?.showProgressHUD()
        interactor?.retrieveMovieList()
    }

    func getMovieList() -> [Movie] {
        return movieList
    }

    func movieCardClicked(with movieItem: Movie) {
        router?.navigateToMovieDetailScreen(of: movieItem)
    }
}

extension MainPresenter: IMainInteractorToPresenter {
    func wsErrorOccurred(with message: String) {
        view?.hideProgressHUD()
        view?.showErrorDialog(with: message)
    }

    func movieListRecieved(_ movieList: [Movie]) {
        self.movieList = movieList
        view?.hideProgressHUD()
        view?.reloadCollectionView()
    }
}
