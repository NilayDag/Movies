//
//  MovieDetailCollectionViewAdapter.swift
//  Movies
//
//  Created by Eda Nilay DAĞDEMİR on 18.12.2020.
//  Copyright © 2020 Eda Nilay DAĞDEMİR. All rights reserved.
//

import UIKit

class MovieDetailCollectionViewAdapter: NSObject {
    private let presenter: IMovieDetailPresenter

    init(presenter: IMovieDetailPresenter) {
        self.presenter = presenter
    }
}

extension MovieDetailCollectionViewAdapter: IBaseAdapter {
    func itemCount() -> Int {
        return getCast().count
    }

    func getVideos() -> [Video] {
        return presenter.getVideos()
    }

    func getCast() -> [Cast] {
        return presenter.getCast()
    }
}

extension MovieDetailCollectionViewAdapter: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - Collection view data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return getCast().count
        case 2:
            return 1
        case 3:
            return getVideos().count
        default:
            return 0
        }
    }

    // swiftlint:disable line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            return setupSectionHeaderCell(collectionView: collectionView, indexPath: indexPath, with: Constants.MovieDetailSectionHeaderCells.cast.title)
        case 1:
            return setupCastCollectionViewCell(collectionView: collectionView, indexPath: indexPath)
        case 2:
            return setupSectionHeaderCell(collectionView: collectionView, indexPath: indexPath, with: Constants.MovieDetailSectionHeaderCells.video.title)
        case 3:
            return setupVideoCollectionViewCell(collectionView: collectionView, indexPath: indexPath)
        default:
            return UICollectionViewCell()
        }
    }

    private func setupSectionHeaderCell(collectionView: UICollectionView, indexPath: IndexPath, with cellHeaderText: String) -> UICollectionViewCell {
        let identifier = SectionHeaderCell.nameOfClass
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? SectionHeaderCell {
            cell.setup(with: cellHeaderText)

            return cell
        }
        return UICollectionViewCell()
    }

    private func setupCastCollectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CastCollectionViewCell.nameOfClass
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? CastCollectionViewCell {
            cell.setup(with: getCast()[indexPath.row])

            return cell
        }
        return UICollectionViewCell()
    }

    private func setupVideoCollectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = VideoCollectionViewCell.nameOfClass
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? VideoCollectionViewCell {
            cell.setup(delegate: self, with: getVideos()[indexPath.row])

            return cell
        }
        return UICollectionViewCell()
    }
    // swiftlint:enable line_length

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if (collectionView.cellForItem(at: indexPath) as? CastCollectionViewCell) != nil,
            let personId = getCast()[indexPath.row].id {
                presenter.castItemClicked(with: personId)
        }
    }
}

extension MovieDetailCollectionViewAdapter: VideoCollectionViewCellDelegate {
    func videoURLClicked(with url: String?) {
        presenter.videoItemClicked(with: url ?? "")
    }
}
