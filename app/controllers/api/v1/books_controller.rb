class Api::V1::BooksController < ApplicationController
  def index
    book = BooksFacade.find_books(params[:location], params[:quantity])
  end
end
