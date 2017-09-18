require csv

class RegionFinder
  
  def initialize(cities_areas)
    @cities_areas = cities_areas
    @cities_areas.sort_by! { |(city,area)| -city.length }
  end
  
  def from_string(text)
    found = cities_areas.find { |(city,area)| text.include? city }
    if found then found[1] else nil
  end
      
  def self.new_from_csv(file)
    self.new(CSV.read(file))
  end
      
end