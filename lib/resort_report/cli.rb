#CLI Controller
class CLI

def call
  puts ""
  puts "Welcome to Snow Report!".colorize(:cyan)
  start
end

def start
  Scraper.scrape_index
  @input = ""
  while @input != "exit"
    @search = "search".colorize(:yellow)
    @list = "list".colorize(:yellow)
    @exit = "exit".colorize(:yellow)
  puts ""
  puts "To get a list of all resorts type #{@list}."
  puts ""
  puts "or".colorize(:red)
  puts ""
  puts "To search by state type #{@search}."
  puts ""
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
    @input = gets.strip.downcase
  if @input == "exit"
    goodbye
    exit
  elsif !location.downcase.include?(@input)
    puts ""
    puts "Im sorry, that is not a state from the list".colorize(:light_blue)
  else
    puts ""
    puts "Resorts in #{@input.split(' ').map(&:capitalize).join(' ')}:".colorize(:cyan)
    puts ""
  Report.all.each_with_index do |report, i|
  if report.location.downcase == @input
    puts "#{i + 1}. #{report.name}".colorize(:green)
  elsif @input == "list"
    list_resorts
      end
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
    if @input.to_i > 0
      the_report = Report.all[@input.to_i-1]
      puts ""
      puts "-----------#{the_report.name}, #{the_report.location}------------".colorize(:light_cyan)
      puts ""
      puts ""
      puts "New Snow in #{the_report.oneday_new_snow}".colorize(:cyan)
      puts ""
      puts "New Snow in #{the_report.threeday_new_snow}".colorize(:cyan)
      puts ""
      puts "Snow Depth (Base/Summit): #{the_report.base_depth}".colorize(:cyan)
      puts ""
      puts "Lifts Open: #{the_report.lifts}".colorize(:cyan)
      puts ""
      puts "Website: #{the_report.url}".colorize(:cyan)
      puts ""
      puts ""
    elsif @input == "list"
      list_resorts
    elsif @input == "search"
      list_by_location
    elsif @input != "exit" && @input != "list" && @input != "search"
      puts ""
      puts "Not sure what you want.".colorize(:red)
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
