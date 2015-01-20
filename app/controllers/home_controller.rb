class HomeController < ApplicationController

	def index    
    if params[:search]
      @results = Course.search { fulltext params[:search], minimum_match: 1 }.results
    end
  end
  
end
