class Report
attr_accessor :location, :base_depth, :lifts, :oneday_new_snow, :threeday_new_snow, :url, :status, :trails, :temp, :description, :parks, :new_snow
attr_reader :name

@@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    sorted_all = @@all.sort_by {|report| report.name}
    sorted_all.shift
    sorted_all.shift
    sorted_all.shift
    sorted_all.shift
    sorted_all.shift
    sorted_all
  end

  # def  self.new_from_scraper(hash)
  #
  # end
end
