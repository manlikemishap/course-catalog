class SearchController < ApplicationController

	def index
    # Both selected or unselected - same thing
    semester = params[:spring].nil? ? "Fall" : "Spring" if params[:spring].to_i != params[:fall].to_i

    dists = [:q, :w, :d].map { |dist| params[dist].nil? ? nil : dist }.compact

    attrs = params[:attrs].map { |a| Attr.find_by(name: a) }.compact if params[:attrs]

    divs = ["1", "2", "3"].map { |div| params[div].nil? ? nil : div.to_i }.compact

    # Map course to score
    @results = {}

    t1 = Time.now

    if params[:search]
      search = Course.search do 
        fulltext params[:search], minimum_match: 1
        with(:semesters).any_of([semester]) if semester
      end
      search.each_hit_with_result do |hit, course|
        @results[course] = 5 * hit.score
      end
    end

    if dists
      # They're separated in order to allow boosting. Matching multiple scopes
      # isn't treated (by Solr) as any better than matching 1
      dists.each do |dist|
        search = Course.search do
          with(dist).any_of(dists)
        end
        search.results.each do |course|
          @results[course] = @results[course].nil? ? 2 : @results[course] * 2
        end
      end
    end

    if divs
      Course.all.each do |course|
        @results[course] = @results[course].nil? ? 2 : @results[course] * 2 if divs.include?(course.division)
      end
    end
    @divs = divs
    @f = params["1"]

    @results = @results.sort_by { |k,v| -(v || 0) }

    t2 = Time.now
    @elapsed = (t2 - t1) * 1000.0

  end
  
end