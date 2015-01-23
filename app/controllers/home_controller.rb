class HomeController < ApplicationController

	def index
    @pre_fall = Date.today.month >= 3 && Date.today.month <= 9
    @pre_spring = !@pre_fall
    
    if params[:search]
      @hits = Course.search { fulltext params[:search], minimum_match: 1 }.each_hit_with_result
    end
  end
  
end