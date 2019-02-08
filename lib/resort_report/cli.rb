#CLI Controller
class CLI

def call
  puts ""
  puts "Welcome to Snow Report!"
  start
end

def start
  Scraper.scrape
  puts ""
  puts "To get a list of all resorts type 'list'."
  puts ""
  puts "Or"
  puts ""
  puts "Enter a state from the list below to get a list of the resorts in that state:"
  puts ""
  puts "States: #{location}"

  puts ""
  list_by_location
  menu
  end

  def location
    locations = []
    sorted_reports = Report.all.sort_by {|report| report.location}
    sorted_reports.each do |report|
      locations << report.location
    end
    locations.uniq.join(", ")
  end

  def list_resorts
    Report.all.each_with_index do |report, i|
      puts "#{i + 1}. #{report.name}"
    end
  end

  def list_by_location
  input = gets.strip.downcase
  @reports = Report.all
  puts ""
  puts "Resorts in #{input.split(' ').map(&:capitalize).join(' ')}:"
  puts ""
  @reports.each_with_index do |report, i|
    if report.location.downcase == input
    puts "#{i + 1}. #{report.name}"
  elsif input == "list"
    list_resorts
    break
    end
  end
end

def menu
  input = nil
  while input != "exit"
    puts ""
    puts "Enter the number of the resort you would like a snow report on or type list or exit:"
    puts ""
    input = gets.strip.downcase
    if input.to_i > 0
      the_report = @reports[input.to_i-1]
      puts "-----------#{the_report.name}, #{the_report.location}------------"
      puts ""
      puts ""
      puts "New Snow in #{the_report.oneday_new_snow}"
      puts ""
      puts "New Snow in #{the_report.threeday_new_snow}"
      puts ""
      puts "Snow Depth (Base/Summit): #{the_report.base_depth}"
      puts ""
      puts "Lifts Open: #{the_report.lifts}"
      puts ""
      puts ""
    elsif input == "list"
      list_resorts
    elsif input == "exit"
      puts ""
      puts "See you tomorrow for more reports!!!"
      puts ""
    else
      puts ""
      puts "Not sure what you want."
      start
      puts ""
    end
  end
end
end
