Fabricator(:component) do 
	#days { %w[MWF 8-9, TR, ]}
end

Fabricator(:lab) do 
	type "Lab"
end

Fabricator(:conference) do 
	type "Conference"
end