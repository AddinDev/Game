//
//  File.swift
//  
//
//  Created by addin on 31/03/21.
//

import SwiftUI
import Combine
import SIECore

public class GetDetailPresenter<
  DetailInteractor: UseCase,
  AddFavouriteInteractor: UseCase,
  RemoveFavouriteInteractor: UseCase
>: ObservableObject
where
  DetailInteractor.Request == String,
  DetailInteractor.Response == DetailModel,
  AddFavouriteInteractor.Request == GameModel,
  AddFavouriteInteractor.Response == Bool,
  RemoveFavouriteInteractor.Request == GameModel,
  RemoveFavouriteInteractor.Response == Bool {
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let _detailUseCase: DetailInteractor
  private let _addFavouriteUseCase: AddFavouriteInteractor
  private let _removeFavouriteUseCase: RemoveFavouriteInteractor

  @Published public var detail: DetailModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  @Published public var isFav: Bool
  
  public init(
    fav: Bool,
    detailUseCase: DetailInteractor,
    favouriteUseCase: AddFavouriteInteractor,
    removeFavouriteUseCase: RemoveFavouriteInteractor
  ) {
    isFav = fav
    _detailUseCase = detailUseCase
    _addFavouriteUseCase = favouriteUseCase
    _removeFavouriteUseCase = removeFavouriteUseCase
  }
  
  public func getDetail(request: DetailInteractor.Request) {
    isLoading = true
    _detailUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          withAnimation {
            self.isLoading = false
          }
        }
      } receiveValue: { detail in
        self.detail = detail
      }.store(in: &cancellables)
  }
  
  public func addFavourite(request: AddFavouriteInteractor.Request) {
    _addFavouriteUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
        case .finished:
          break
        }
      } receiveValue: { _ in
      }.store(in: &cancellables)
  }
  
  public func removeFavourite(request: RemoveFavouriteInteractor.Request) {
    _removeFavouriteUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
        case .finished:
          break
        }
      } receiveValue: { _ in
      }.store(in: &cancellables)
  }
  
  public func changeFav(add: () -> Void, remove: () -> Void) {
    if isFav == true {
      remove()
      isFav.toggle()
    } else if isFav == false {
      add()
      isFav.toggle()
    }
  }
  
}
