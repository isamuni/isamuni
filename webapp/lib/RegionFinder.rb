require 'csv'

class RegionFinder
  
  def initialize(cities_areas)
    @cities_areas = cities_areas
    @cities_areas.sort_by! { |(city,area)| -city.length }
  end
  
  def from_string(text)
    found = @cities_areas.find { |(city,area)| text.include? city }
    found ? found[1] : nil
  end
      
  def self.from_csv(file = nil)
    file = file || File.join(__dir__, 'cities.csv')
    self.new(CSV.read(file))
  end

end