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

def self.scrape_report
  self.scrape_resort.each do |url|
    @page = Nokogiri::HTML(open(url))
    @report = Report.new
    @report.url = url
  end
  @report
end

  def self.report_page_scrape
    Report.all.each do |report|
      doc = Nokogiri::HTML(open(report.url))
      report.name = doc.css(".resort_name").text
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
  report.description = doc.css(".snow_report_comment_wrapper").text
  # doc.css("#resort_terrain p.label").each do |label|
  #   doc = Nokogiri::HTML(open(report.url))
  #   if label != "Terrain Parks"
  #     report.parks = " "
  #   else
  #     report.parks = doc.css("#resort_terrain p.#{label} p.value").text
  #   end
  # end
  report
end
end
