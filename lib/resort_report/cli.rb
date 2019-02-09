#CLI Controller
class CLI

def call
  puts ""
  puts "Welcome to Snow Report!"
  start
end

def start
  Scraper.scrape_index
  @input = ""
  while @input != "exit"
  puts ""
  puts "To get a list of all resorts type 'list'."
  puts ""
  puts "Or"
  puts ""
  puts "To search by state type 'search'."
  puts ""
  # puts "States: #{location}"
  # puts ""
  @input = gets.chomp
  if @input == "list"
    list_resorts
    menu
  elsif @input == "search"
  list_by_location
  menu
      end
    end
    goodbye
  end

  def location
    @locations = []
    sorted_reports = Report.all.sort_by {|report| report.location}
    sorted_reports.each do |report|
      @locations << report.location
    end
    @locations.uniq.join(", ")
  end

  def list_resorts
    Report.all.each_with_index do |report, i|
      puts "#{i + 1}. #{report.name}"
    end
  end

  def list_by_location
    puts "Here are all the states to choose from."
    puts ""
    puts "States: #{location}"
    puts ""
    puts "Which state would you like a list of resorts from?"
    puts ""
  input = gets.strip.downcase
  puts ""
  puts "Resorts in #{input.split(' ').map(&:capitalize).join(' ')}:"
  puts ""
  Report.all.each_with_index do |report, i|
    if report.location.downcase == input
    puts "#{i + 1}. #{report.name}"
  elsif input == "list"
    list_resorts
binding.pry
    end
  end
end

def menu
  @input = nil
  while @input != "exit"
    puts ""
    puts "Enter the number of the resort you would like a snow report on or type list or exit:"
    puts ""
    @input = gets.strip.downcase
    if @input.to_i > 0
      the_report = Report.all[@input.to_i-1]
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
      puts "Website: #{the_report.url}"
      puts ""
      puts ""
    elsif @input == "list"
      list_resorts
    elsif @input == "search"
      list_by_location
    # elsif @input == "exit"
    # goodbye
  elsif @input != "exit" && @input != "list" && @input != "search"
      puts ""
      puts "Not sure what you want."
      puts ""
    end
  end
  end
  def goodbye
    puts ""
    puts "See you tomorrow for more reports!!!"
    puts ""
  end
end
