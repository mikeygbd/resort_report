class Scraper
attr_accessor  :location, :base_depth, :lifts, :oneday_new_snow, :threeday_new_snow, :url, :status, :trails, :temp, :description, :parks, :new_snow
@@urls = []
@@urls2 = []
  def self.get_page
    Nokogiri::HTML(open("/Users/michaelsoares/resort_report/bin/index.html"))
  end

  def self.resort_rows
    self.get_page.css("tbody tr")
  end

    def self.scrape_index
      self.resort_rows.each do |resort_row|
        name = "#{resort_row.css(".name a").text}"
        report = Report.new(name)
        # report.url = "https://www.onthesnow.com#{resort_row.css(".name a").attr("href").value}"
        report.location = "#{resort_row.css(".rRegion.link-light a").text.split(",").shift}"
        report.oneday_new_snow = "#{resort_row.css("td.rLeft.b.nsnow").text.split("\"")[0]}"
        report.threeday_new_snow = "#{resort_row.css("td.rLeft.b.nsnow").text.split("\"")[1]}"
        report.base_depth = "#{resort_row.css("td.rMid.c").text.split("\"")[0]} #{resort_row.css("td.rMid.c").text.split("\"")[1]}"
        report.lifts =  "#{resort_row.css(".rMid.open_lifts").text}"
        # report.status = self.scrape_report.css(".current_status").text
        # report.trails = self.scrape_report.css("#resort_terrain p.open").first.text
        # report.lifts = self.scrape_report.css("#resort_terrain p.open")[1].text
        # report.temp = self.scrape_report.css(".temp").first.text
        # report.new_snow = self.scrape_report.css(".predicted_snowfall")[6].text
        # report.parks = self.scrape_report.css("#resort_terrain p.value")[3].text
        # report.description = self.scrape_report.css(".snow_report_comment_wrapper").text

        # @@urls << report.url
    # binding.pry
      report
      end
    end

    # def self.url
    #   url = "https://www.onthesnow.com#{get_page.css(".name a").attr("href").value}"
    #   url
    # end


#   def self.scrape_resort
#     @@urls.each do |url|
#     resort_page = Nokogiri::HTML(open(url))
#     report_page = "https://www.onthesnow.com/#{resort_page.css(".dropDownContent.conditions a").attr("href").value}"
#     @@urls2 << report_page
#     @@urls2
# # binding.pry
#     end
#   end
#
#   def self.scrape_report
#     self.scrape_resort.each do |url|
#       page = Nokogiri::HTML(open(url))
#       page
#       # binding.pry
#   end
# end

end
