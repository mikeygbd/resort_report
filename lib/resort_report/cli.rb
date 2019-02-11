#CLI Controller
class CLI

  @@reports = []

def call
  puts ""
  puts "Welcome to Snow Report!".colorize(:cyan)
  puts ""
  puts "Please wait loading reports...".colorize(:light_black)
  puts ""
  Scraper.scrape_report
  Scraper.report_page_scrape
  start
end

def start
  @input = ""
  while @input != "exit"
    @search = "search".colorize(:yellow)
    @list = "list".colorize(:yellow)
    @exit = "exit".colorize(:yellow)
  puts ""
  puts "To get a list of all resorts in the United States type #{@list}."
  puts ""
  puts "or".colorize(:red)
  puts ""
  puts "To search by state type #{@search}."
  puts ""
  puts "or".colorize(:red)
  puts ""
  puts "Type in the name of the resort you would like a snow report for."
  puts ""
  @input = gets.chomp
  if @input == "list"
    list_resorts
    menu
  elsif @input == "search"
  list_by_location
  menu
  end
  Report.all.each do |report|
  if @input.downcase == report.name.downcase
    find_by_name(@input)
    menu
        end
      end
    end
    goodbye
  end

  def location
    @locations = []
    @reports = Report.all
    sorted_reports = @reports.sort_by {|report| report.location}
    sorted_reports.each do |report|
      @locations << report.location
    end
    @locations.uniq.join(", ")
  end

  def list_resorts
    puts ""
    puts "Here is a list of all the resorts to choose from:".colorize(:light_blue)
    puts ""
    Report.all.each_with_index do |report, i|
      puts "#{i + 1}. #{report.name}".colorize(:green)
    end
  end

  def list_by_location
    puts ""
    puts "Here are all the states to choose from.".colorize(:light_blue)
    puts ""
    puts "States: #{location.colorize(:yellow)}"
    puts ""
    puts "Which state would you like a list of resorts from?".colorize(:light_blue)
    puts ""
    puts "Type a state:"
    puts ""
    puts "or".colorize(:red)
    puts ""
    puts "Type: #{@list} or #{@exit}"
    puts ""
    @input = gets.strip.downcase
  if @input == "exit"
    goodbye
    exit
  elsif @input == "list"
    list_resorts
  elsif !location.downcase.include?(@input) && @input != "list"
    puts ""
    puts "Im sorry, that is not a state from the list".colorize(:light_red)
  else
    puts ""
    puts "Resorts in #{@input.split(' ').map(&:capitalize).join(' ')}:".colorize(:cyan)
    puts ""
    Report.all.each_with_index do |report, i|
  if report.location.downcase == @input
    puts "#{i + 1}. #{report.name}".colorize(:green)
      end
    end
  end
end

def find_by_name(name)
    name = name.downcase
    Report.all.each_with_index do |report, i|
      if report.name.downcase == name
        updated_report = Scraper.update_report(report)
        puts ""
        puts "-----------#{updated_report.name}, #{updated_report.location}------------".colorize(:light_cyan)
        puts ""
        puts ""
        puts "Resort Status: #{updated_report.status}".colorize(:cyan)
        puts ""
        puts "Temperature At The Summit: #{updated_report.summit_temp}".colorize(:cyan)
        puts ""
        puts "Temperature At The Base: #{updated_report.base_temp}".colorize(:cyan)
        puts ""
        puts "Yesterdays Snow: #{updated_report.yesterday_snow}.".colorize(:cyan)
        puts ""
        puts "Todays Expected Snow: #{updated_report.today_snow}.".colorize(:cyan)
        puts ""
        puts "Tomorrows Expected Snow: #{updated_report.tomorrow_snow}.".colorize(:cyan)
        puts ""
        puts "Snow Depth At The Base: #{updated_report.lower_depth}".colorize(:cyan)
        puts ""
        puts "Snow Depth At The Summit: #{updated_report.upper_depth}".colorize(:cyan)
        puts ""
        puts "Snow Conditions At The Base: #{updated_report.lower_conditions}".colorize(:cyan)
        puts ""
        puts "Snow Conditions At The Summit: #{updated_report.upper_conditions}".colorize(:cyan)
        puts ""
        puts "Lifts Open: #{updated_report.lifts}".colorize(:cyan)
        puts ""
        puts "Runs Open: #{updated_report.trails}".colorize(:cyan)
        puts ""
        puts "Parks Open: #{updated_report.parks}".colorize(:cyan)
        puts ""
        puts "Website: #{updated_report.url}".colorize(:cyan)
        puts ""
        puts ""
        puts "-----------Description------------".colorize(:cyan)
            puts ""
            puts "#{updated_report.description}".colorize(:cyan)
            puts ""
      end
    end
  end

def menu
  @input = nil
  while @input != "exit"
    puts ""
    puts "Enter the number of the resort you would like a snow report on"
    puts ""
    puts "or".colorize(:red)
    puts ""
    puts "Type: #{@list}, #{@search} or #{@exit}:"
    @input = gets.strip.downcase
    if @input.to_i > 0 && @input.to_i <= 334
      updated_report = Scraper.update_report(Report.all[@input.to_i - 1])
      puts ""
      puts "-----------#{updated_report.name}, #{updated_report.location}------------".colorize(:light_cyan)
      puts ""
      puts ""
      puts "Resort Status: #{updated_report.status}".colorize(:cyan)
      puts ""
      puts "Temperature At The Summit: #{updated_report.summit_temp}".colorize(:cyan)
      puts ""
      puts "Temperature At The Base: #{updated_report.base_temp}".colorize(:cyan)
      puts ""
      puts "Yesterdays Snow: #{updated_report.yesterday_snow}.".colorize(:cyan)
      puts ""
      puts "Todays Expected Snow: #{updated_report.today_snow}.".colorize(:cyan)
      puts ""
      puts "Tomorrows Expected Snow: #{updated_report.tomorrow_snow}.".colorize(:cyan)
      puts ""
      puts "Snow Depth At The Base: #{updated_report.lower_depth}".colorize(:cyan)
      puts ""
      puts "Snow Depth At The Summit: #{updated_report.upper_depth}".colorize(:cyan)
      puts ""
      puts "Snow Conditions At The Base: #{updated_report.lower_conditions}".colorize(:cyan)
      puts ""
      puts "Snow Conditions At The Summit: #{updated_report.upper_conditions}".colorize(:cyan)
      puts ""
      puts "Lifts Open: #{updated_report.lifts}".colorize(:cyan)
      puts ""
      puts "Runs Open: #{updated_report.trails}".colorize(:cyan)
      puts ""
      puts "Parks Open: #{updated_report.parks}".colorize(:cyan)
      puts ""
      puts "Website: #{updated_report.url}".colorize(:cyan)
      puts ""
      puts ""
      puts "-----------Description------------".colorize(:cyan)
          puts ""
          puts "#{updated_report.description}".colorize(:cyan)
          puts ""
    elsif @input == "list"
      list_resorts
    elsif @input == "search"
      list_by_location
    elsif @input != "exit" && @input != "list" && @input != "search"
      puts ""
      puts "Not sure what you want.".colorize(:light_red)
      puts ""
      end
    end
  end
  def goodbye
    puts ""
    puts "See you tomorrow for more reports!!!".colorize(:cyan)
    puts ""
  end
end
