# lib/option_handler.rb
require 'optparse'

class OptionHandler
  def self.parse_options
    options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: main.rb [options] [file/directory]"

      opts.on("-f", "--format FORMAT", "Specify the output format (json/csv)") do |format|
        options[:format] = format
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end.parse!

    options
  end
end
