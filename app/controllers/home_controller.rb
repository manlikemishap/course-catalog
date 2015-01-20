class HomeController < ApplicationController

	def index    
    if params[:search]
      @results = Course.search { fulltext params[:search] }.results
    end
  end
  
end
