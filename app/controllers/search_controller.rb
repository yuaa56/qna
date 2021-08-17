class SearchController < ApplicationController
  #include PgSearch
  
    def index
      skip_authorization
      respond_with (@result = Search.return_results(params[:search]))
    end
  end
  