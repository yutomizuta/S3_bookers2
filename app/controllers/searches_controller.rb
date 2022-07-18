class SearchesController < ApplicationController

  def search
    @books = Book.looks(params[:tag])
  end
end
