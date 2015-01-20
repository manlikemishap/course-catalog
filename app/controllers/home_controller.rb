class HomeController < ApplicationController

	def index    
    if params[:search]
      @hits = Course.search { fulltext params[:search], minimum_match: 1 }.each_hit_with_result
    end
  end
  
end
