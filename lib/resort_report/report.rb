class Report

attr_accessor :name, :location, :summit_temp, :base_temp, :upper_depth, :lower_depth, :lifts, :yesterday_snow, :today_snow, :tomorrow_snow, :url, :status, :trails, :description, :parks, :lower_conditions, :upper_conditions

@@all = []

  def initialize
    @@all << self
  end

  def self.all
    sorted_all = @@all.sort_by {|report| report.name}
    sorted_all
  end
end
