#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'pry'
require 'calendar'

class Application

  def initialize
    @current  = Calendar.new(Date.today)
    @previous = Calendar.new(Date.today.prev_year)
    welcome

    # possible to create additional years in a single instance of Calendar
    # code below would create @current.prev_year
    # @current.create_year(Date.today.prev_year, "prev_year")
  end

  def welcome
    puts "Welcome to my Calendar App"
  end

end
Pry.config.prompt_name = "Calendar"
Pry.config.prompt = proc { |obj, nest_level, _ |"[#{Pry.current_line}]#{Pry.config.prompt_name}: " }
Pry.start Application.new
