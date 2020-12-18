//
//  MovieDetailContract.swift
//  Movies
//
//  Created by Eda Nilay DAĞDEMİR on 18.12.2020.
//  Copyright © 2020 Eda Nilay DAĞDEMİR. All rights reserved.
//

import Foundation

protocol IMovieDetailView: IBaseView {
    func reloadCollectionView()
}

protocol IMovieDetailPresenter: IBasePresenter {
    // TODO: Declare presentation methods
//    func getMovieDetails() -> Movie
//    func videoItemClicked(with video: Video?)
//    func castItemClicked(with person: Person)
    func setSelectedMovieId(with movieId: Int)
    func getMovieId() -> Int?
    func getMovieDetailItem() -> MovieDetail?
    func getVideos() -> [Video]
    func getCast() -> [Cast]
}

protocol IMovieDetailInteractor: class {
    func retrieveMovieDetails(with movieId: Int)
    func retrieveVideos(with movieId: Int)
    func retrieveCast(with movieId: Int)
}

protocol IMovieDetailInteractorToPresenter: IBaseInteractorToPresenter {
    func movieDetailsRecieved(_ movieDetailItem: MovieDetail)
    func videosRecieved(_ videos: [Video])
    func castRecieved(_ cast: [Cast]) 
}

protocol IMovieDetailRouter: class {
//    func navigateToPersonDetailScreen(of castItem: Person)
}
