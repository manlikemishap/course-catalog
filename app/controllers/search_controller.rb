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
        @results[course] = hit.score.nil? ? 1 : 5 * hit.score
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

    #low = @results[@results.keys[20]]
    #high = @results[@results.keys[3]]
    #n = Course.count
    #x = []
    #(1..5).each { |i| x.push(10 + rand(n - 10)) }
    #x.each { |i| @results[@results.keys[30 + rand(n - 30)]] = low + rand(high-low) }

    @results = @results.sort_by { |k,v| -(v || 0) }[0..50]

    t2 = Time.now
    @elapsed = (t2 - t1) * 1000.0

  end














  
  def newindex
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
        @results[course] = hit.score.nil? ? 1 : 5 * hit.score
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

    @results = @results.sort_by { |k,v| -(v || 0) }[0..50]

    t2 = Time.now
    @elapsed = (t2 - t1) * 1000.0

  end

  def lookup
    @course = Course.find_by(id: params[:id])

    respond_to do |format|
      #format.json { render :json => results.to_json }
      format.js {}
    end

  end

end