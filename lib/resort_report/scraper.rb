class Scraper
attr_accessor :report, :location, :summit_temp, :base_temp, :upper_depth, :lower_depth, :lifts, :yesterday_snow, :today_snow, :tomorrow_snow, :url, :status, :trails, :description, :parks, :lower_conditions, :upper_conditions

STATES = ["Alaska", "Arizona", "California", "Colorado", "Idaho", "Illinois", "Michigan", "Minnesota", "Missouri", "Montana", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "Oregon", "Pennsylvania", "Utah", "Vermont", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
@@urls = []
@@urls2 = []
@@pages = []

  def self.get_page
    Nokogiri::HTML(open("/Users/michaelsoares/resort_report/bin/index.html"))
  end

  def self.resort_rows
    self.get_page.css("tbody tr")
  end

  def self.scrape_link_from_index
    self.resort_rows[0..104].each do |resort_row|
      url = "https://www.onthesnow.com#{resort_row.css(".name a").attr("href").value}"
      @@urls << url
    end
    @@urls
  end

  def self.scrape_resort
  self.scrape_link_from_index.each do |url|
  resort_page = Nokogiri::HTML(open(url))
  report_url = "https://www.onthesnow.com/#{resort_page.css(".dropDownContent.conditions a").attr("href").value}"
  @@urls2 << report_url
  end
  @@urls2
end

# def self.scrape_index
#   self.resort_rows[0..104].each do |resort_row|
#     @name = "#{resort_row.css(".name a").text}"
#     @state = "#{resort_row.css(".rRegion.link-light a").text.split(",").shift}"
#     # binding.pry
#   end
# end


def self.scrape_report
  self.scrape_resort.each do |url|
    @page = Nokogiri::HTML(open(url))
    @report = Report.new
    @report.url = url
    # @report.location = @state
    # binding.pry
  end
  @report
end

  def self.report_page_scrape
    Report.all.each do |report|
      doc = Nokogiri::HTML(open(report.url))
      report.name = doc.css(".resort_name").text
      # report.status = doc.css(".current_status").text
      # report.trails = doc.css("#resort_terrain p.open").first.text
      # # report.lifts = doc.css("#resort_terrain p.open")[1].text
      # report.temp = doc.css(".temp").first.text
      # report.new_snow = doc.css(".predicted_snowfall")[6].text
      # # report.parks = doc.css("#resort_terrain p.value")[3].text
      # report.description = doc.css(".snow_report_comment_wrapper").text
      # binding.pry

      report.location = ''
    doc.css(".relatedRegions a").each do |location|
      if STATES.include?(location.text)
        report.location = location.text
      end
    end
    report
  end
end



def self.update_report(report)
  # if !report.status
  doc = Nokogiri::HTML(open(report.url))
  #update object with attributes
  report.status = doc.css(".current_status").text
  report.trails = doc.css("#resort_terrain p.open").first.text
  report.lifts = doc.css("#resort_terrain p.open")[1].text
  report.summit_temp = doc.css(".temp").first.text
  report.base_temp = doc.css(".temp")[1].text
  report.yesterday_snow = doc.css(".predicted_snowfall")[4].text
  report.today_snow = doc.css(".predicted_snowfall")[5].text
  report.tomorrow_snow = doc.css(".predicted_snowfall")[6].text
  report.upper_depth = doc.css(".elevation.upper div.bluePill").text
  report.lower_depth = doc.css(".elevation.lower div.bluePill").text
  report.lower_conditions = doc.css(".elevation.lower div.surface").text
  report.upper_conditions = doc.css(".elevation.upper div.surface").text
  report.parks = doc.css("#resort_terrain p.value")[3].text
  report.description = doc.css(".snow_report_comment_wrapper").text
  # binding.pry
  report
end

end


#     def self.scrape_link_from_index
#       # self.add_page
#       self.resort_rows[0..104].each do |resort_row|
#         # name = "#{resort_row.css(".name a").text}"
#         # report = Report.new(name)
#         url = "https://www.onthesnow.com#{resort_row.css(".name a").attr("href").value}"
#         @@urls << url
#
#
#
#         # report.location = "#{resort_row.css(".rRegion.link-light a").text.split(",").shift}"
#         # report.oneday_new_snow = "#{resort_row.css("td.rLeft.b.nsnow").text.split("\"")[0]}"
#         # report.threeday_new_snow = "#{resort_row.css("td.rLeft.b.nsnow").text.split("\"")[1]}"
#         # report.base_depth = "#{resort_row.css("td.rMid.c").text.split("\"")[0]} #{resort_row.css("td.rMid.c").text.split("\"")[1]}"
#         # report.lifts =  "#{resort_row.css(".rMid.open_lifts").text}"
#
#         # binding.pry
#         # report.status = doc.css(".current_status").text
#         # report.trails = doc.css("#resort_terrain p.open").first.text
#         # report.lifts = doc.css("#resort_terrain p.open")[1].text
#         # report.temp = doc.css(".temp").first.text
#         # report.new_snow = doc.css(".predicted_snowfall")[6].text
#         # report.parks = doc.css("#resort_terrain p.value")[3].text
#         # report.description = doc.css(".snow_report_comment_wrapper").text
#         # binding.pry
#     #   end
#     # end
#
#     #report objects that we currently have are outdated
#     # get new links from an index page, for each report object and update its resort url
#     #we can iterate through each report object, and during that iteration do several steps
#     # scrape the resort's live page and update report object with a report_url
#     # scrape the report url and update that report object with attributes
#
#     # def self.url
#     #   url = "https://www.onthesnow.com#{get_page.css(".name a").attr("href").value}"
#     #   url
#     # end
#
#   def self.scrape_resort
#     @@urls.each do |url|
#     resort_page = Nokogiri::HTML(open(url))
#     report_url = "https://www.onthesnow.com/#{resort_page.css(".dropDownContent.conditions a").attr("href").value}"
#     @@urls2 << report_url
# # binding.pry
#     end
#     @@urls2
#   end
#
#   def self.scrape_report
#     self.scrape_resort.map do |url|
#       page = Nokogiri::HTML(open(url))
#       @@pages = []
#       @@pages << page
#       binding.pry
#   end
#   @@pages
# end
#
#   def self.add_page
#     @@pages.each do |page|
#       report = Report.new
#       report.url = page
#
#     end
#   end
#
#   def self.scrape
#     Report.all.each do |report|
#       name = self.resort_rows.css(".name a").text
#        report = Report.new(name)
#       report.location = self.resort_rows.css(".rRegion.link-light a").text.split(",").shift
#     end
#   end
#
#   def self.update_report(report)
#   if !report.status
#   doc = Nokogiri::HTML(open(report.report_url))
#   #update object with attributes
#   report.status = doc.css(".current_status").text
#   report.trails = doc.css("#resort_terrain p.open").first.text
#   report.lifts = doc.css("#resort_terrain p.open")[1].text
#   report.temp = doc.css(".temp").first.text
#   report.new_snow = doc.css(".predicted_snowfall")[6].text
#   report.parks = doc.css("#resort_terrain p.value")[3].text
#   report.description = doc.css(".snow_report_comment_wrapper").text
#   end
#   report
# end
#
# end
