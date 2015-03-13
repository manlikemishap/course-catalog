require 'csv'

File.open("times.json", "w") do |file|
  x = Set.new
  CSV.foreach("catalog1415.csv", :headers => true) do |row|
    s =  "\{"
    (1..3).each do |i|
      start = false
      ["Pat#{i}", "Start Time#{i}", "End Time#{i}"].each do |attr|
        if !row["Pat2"].nil? && row["Pat1"].nil?
          puts row
          exit
        end
        break if row[attr].blank?
        s += "," if start 
        s += "\"#{attr}\":\"#{row[attr]}\"" if !row[attr].blank?
        start = true
      end
    end
    if s.length > 3 || s == "TBA"
      x.add( s.to_s + "\},\n" )
    end
  end
  x.each do |t|
    file.write(t)
  end
end
