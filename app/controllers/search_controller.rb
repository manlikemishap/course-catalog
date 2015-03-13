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

    if !params[:search].blank?
      search = Course.search do 
        fulltext params[:search], minimum_match: 1
        with(:semesters).any_of([semester]) if semester
      end
      search.each_hit_with_result do |hit, course|
        @results[course] = hit.score.nil? ? 1 : 5 * hit.score
      end
    end

    # if divs
    #   search = Course.search do 
    #     with(:division).any_of(divs)
    #   end
    #   search.each_hit_with_result do |hit, course|
    #     @results[course] = hit.score.nil? ? 2 : 2 * hit.score
    #   end
    # end

    # if dists
    #   # First get that it matches any, then score it later once we know it matches at least 1
    #   dists.each do |dist|
    #     search = Course.search do 
    #       with(dist).equal_to(true)
    #     end
    #     search.each_hit_with_result do |hit, course|
    #       @results[course] = hit.score.nil? ? 2 : 2 * hit.score
    #     end        
    #   end
    # end

    # Do divs and dists in a single loop
    if !divs.nil? || !dists.nil?
      Course.all.each do |course|
        if !divs.nil? && divs.include?(course.division)
          @results[course] = @results[course].nil? ? 2 : @results[course] * 2
        end

        if !dists.nil?
          dists.each do |dist|
            if course[dist] == true # Weird I know
              @results[course] = @results[course].nil? ? 2 : @results[course] * 2
            end
          end
        end
      end
    end

    # Check if there is any point to sorting (more than 1 thingy specified)
    if divs.size > 1 || dists.size > 1 || params[:search]

      @results = @results.sort_by { |k,v| -(v || 0) }
      @results = Hash[@results.map {|key, value| [key, value]}]

      serendipity = params[:serendipity]
      if params[:search].nil? && !serendipity.nil? && (serendipity = serendipity.to_i) > 0
        @results = serendipitize(@results, serendipity)
      else
        @results = @results.to_a
      end

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

  private

  def serendipitize(results, serendipity)
    limit = 30 # how many things ot return (not including serendipity)

    # Take top 50 from @results
    temp = []
    i = 0
    low = 0 # used to figure out lower bound on the top 50 scores
    results.each do |course, score|
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
          if results[random].to_i < low # check it isnt in the top <limit> already
            temp.insert(i * 10 + rand(10), random)
            results[random] = -1 # mark it as a serendipity course
          end
        end
      end
    end

    x = Hash.new
    temp.each { |course| x[course] = @results[course] }
    return x    
  end

end