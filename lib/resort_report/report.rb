class Report
attr_accessor :location, :base_depth, :lifts, :oneday_new_snow, :threeday_new_snow
attr_reader :name

@@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    sorted_all = @@all.sort_by {|report| report.name}
    sorted_all
  end
end
