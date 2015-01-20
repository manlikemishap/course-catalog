Fabricator(:component) do 
	days { JSON.parse(File.read("#{Rails.root}/times.json")).sample.values.join(" ") }	
end

Fabricator(:lab) do 
	type "Lab"
end

Fabricator(:conference) do 
	type "Conference"
end