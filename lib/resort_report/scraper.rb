class Scraper

attr_accessor :report, :location, :summit_temp, :base_temp, :upper_depth, :lower_depth, :lifts, :yesterday_snow, :today_snow, :tomorrow_snow, :url, :status, :trails, :description, :parks, :lower_conditions, :upper_conditions

STATES = ["Alaska", "Arizona", "California", "Colorado", "Idaho", "Illinois", "Michigan", "Minnesota", "Missouri", "Montana", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "Oregon", "Pennsylvania", "Utah", "Vermont", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

  def self.get_page
    Nokogiri::HTML(open("/Users/michaelsoares/resort_report/bin/index.html"))
  end

  def self.resort_rows
    self.get_page.css("tbody tr")
  end

  def self.scrape_link_from_index
    url =[]
    self.resort_rows.each do |resort_row|
      if resort_row.css(".name a").attr("href") != nil
        url << "https://www.onthesnow.com#{resort_row.css(".name.link-light a").attr("href").value}"
        # binding.pry
      end
    end
    url
  end

  def self.scrape_resort
    self.scrape_link_from_index.map do |url|
      resort_page = Nokogiri::HTML(open(url))
      report_url = "https://www.onthesnow.com/#{resort_page.css(".dropDownContent.conditions a").attr("href").value}"
      report_url
    end
  end

def self.scrape_report
  self.scrape_resort.each do |url|
    doc = Nokogiri::HTML(open(url))
    report = Report.new
    report.url = url
  end
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

  # def self.find_url_from_name(report)
  #     self.scrape_resort.each do |url|
  #       @url = url
  #       if @url != nil
  #       name1 = @url.split("/")[5]
  #       name2 = name1.split("-")
  #       @name = name2.join(" ")
  #
  #     end
  #       if report.name == @name
  #         report.url = @url
  #     end
  #   end
  # end



def self.update_report(report)
  doc = Nokogiri::HTML(open(report.url))
  #update object with attributes
  report.status = doc.css(".current_status").text
  report.trails = doc.css("#resort_terrain p.open").first.text
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
    if doc.css("#resort_terrain p.open")[1] != nil
      report.lifts = doc.css("#resort_terrain p.open")[1].text
    end
    if  doc.css("#resort_terrain p.value")[3] != nil
        report.parks = doc.css("#resort_terrain p.value")[3].text

      end
  report
  end
end
