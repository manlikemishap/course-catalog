class SearchController < ApplicationController

	def index
    # Both selected or unselected - same thing
    semester = params[:spring].nil? ? "Fall" : "Spring" if params[:spring].to_i != params[:fall].to_i

    dists = [:q, :w, :d].map { |dist| params[dist].nil? ? nil : dist }.compact

    attrs = params[:attrs].map { |a| Attr.find_by(name: a) }.compact if params[:attrs]

    divs = ["1", "2", "3"].each { |div| div.to_i if params["div"]}.compact

    # Map course => score
    @results = {}
    if params[:search]
      Course.search { fulltext params[:search], minimum_match: 1 }.each_hit_with_result do |hit, course|
        @results[course] = hit.score
      end
    end

    Course.all.each do |course|
      # Set it to 0 if it hasn't gotten any score yet from query matching
      @results[course] ||= 0

      @results[course] += 1 if course.sections.map { |s| s.semester == semester }.any?

      dists.each { |dist| @results[course] += 1 if course[dist] }

      divs.each { |div| @results[course] += 1 if course[div] }

      # iterate over attr attributes, eg HISTXYZ
      attrs.each { |attr| @results[course] += 1 if course.attrs.include? attr } if attrs
    end

    @results = @results.sort_by { |k,v| -v }
  end
  
end