# ArgumentHandler.rb
class ArgumentHandler
  def initialize(args)
    @args = args
  end
  
  def parse_arguments
    @args.first
  end
end