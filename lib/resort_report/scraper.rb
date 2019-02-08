class Scraper
attr_accessor  :location, :base_depth, :lifts, :oneday_new_snow, :threeday_new_snow

  def self.get_page
    Nokogiri::HTML(open("/Users/michaelsoares/snow_report/bin/index.html"))
  end

  def self.resort_rows
    self.get_page.css("tbody tr")
  end

    def self.scrape
      self.resort_rows.each do |resort_row|
        name = "#{resort_row.css(".name a").text}"
        report = Report.new(name)
        report.location = "#{resort_row.css(".rRegion.link-light a").text.split(",").shift}"
        report.oneday_new_snow = "#{resort_row.css("td.rLeft.b.nsnow").text.split("\"")[0]}"
        report.threeday_new_snow = "#{resort_row.css("td.rLeft.b.nsnow").text.split("\"")[1]}"
        report.base_depth = "#{resort_row.css("td.rMid.c").text.split("\"")[0]} #{resort_row.css("td.rMid.c").text.split("\"")[1]}"
        report.lifts =  "#{resort_row.css(".rMid.open_lifts").text}"
        # binding.pry
      report
      end
    end
  end
