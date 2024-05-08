#!/usr/bin/env ruby

# lib/ScreenPrinter.rb - Print output to the screen

require_relative "../../utils/Colors"

module ScreenPrinter
  def self.print_message(message)
    puts message
  end

  def self.print_newline
    puts
  end
end
