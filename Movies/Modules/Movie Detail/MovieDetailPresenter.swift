//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Eda Nilay DAĞDEMİR on 18.12.2020.
//  Copyright © 2020 Eda Nilay DAĞDEMİR. All rights reserved.
//

import Foundation

class MovieDetailPresenter {

    // MARK: Properties
    weak var view: IMovieDetailView?
    var router: IMovieDetailRouter?
    var interactor: IMovieDetailInteractor?

    private var movieId: Int?
    private var movieDetailItem: MovieDetail?
    private var cast: [Cast]?
    private var videos: [Video]?
}

extension MovieDetailPresenter: IMovieDetailPresenter {
    func viewDidLoad() {
        if let id = movieId {
            view?.showProgressHUD()
            interactor?.retrieveMovieDetails(with: id)
            interactor?.retrieveCast(with: id)
            interactor?.retrieveVideos(with: id)
        }
        print("here count: \(getCast().count)")
        print("here count 2: \(getVideos().count)")
    }

    func setSelectedMovieId(with movieId: Int) {
        self.movieId = movieId
    }

    func getMovieId() -> Int? {
        return movieId ?? nil
    }

    func getMovieDetailItem() -> MovieDetail? {
        return movieDetailItem ?? nil
    }

    func getVideos() -> [Video] {
        return videos ?? []
    }

    func getCast() -> [Cast] {
        return cast ?? []
    }
}

extension MovieDetailPresenter: IMovieDetailInteractorToPresenter {
    func wsErrorOccurred(with message: String) {
        view?.hideProgressHUD()
        view?.showErrorDialog(with: message)
    }

    func movieDetailsRecieved(_ movieDetailItem: MovieDetail) {
        self.movieDetailItem = movieDetailItem
    }

    func videosRecieved(_ videos: [Video]) {
        self.videos = videos
        view?.hideProgressHUD()
    }

    func castRecieved(_ cast: [Cast]) {
        self.cast = cast
    }
}
