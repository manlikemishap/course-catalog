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


    limit = 30 # how many things ot return (not including serendipity)

    # Bug: if the number of results too low


    serendipity = params[:serendipity]

    @results = @results.sort_by { |k,v| -(v || 0) }
    @results = Hash[@results.map {|key, value| [key, value]}]

    if !serendipity.nil? && (serendipity = serendipity.to_i) > 0
      # Take top 50 from @results
      temp = []
      i = 0
      low = 0 # used to figure out lower bound on the top 50 scores
      @results.each do |course, score|
        temp.push(course)
        low = score
        if i >= limit
          break
        end
        i += 1
      end

      (limit / 10).times do |i|
        serendipity.times do
          random = Course.find_by(id: rand(1 + Course.count))
          if !random.nil?
            if @results[random].to_i < low # check it isnt in the top <limit> already
              temp.insert(i * 10 + rand(10), random)
              @results[random] = -1 # mark it as a serendipity course
            end
          end
        end
      end

      x = Hash.new
      temp.each { |course| x[course] = @results[course] }
      @results = x

    else
      @results = @results.to_a[0..29]
    end

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