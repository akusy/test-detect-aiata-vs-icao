class FlightClassifier

  def initialize argv = []
    self.argv = argv
  end

  def start
    if @argv.include? '--help'
      puts help_info
    elsif @argv.length >= 2
      classify
    else
      puts "Wrong number of arguments (#{@argv.length} for 2). Type '--help' to get more information"
    end
  end

  private
  attr_accessor :argv

  def classify
    FlightSheet.new(@argv[0], @argv[1]).create
  end

  def help_info
    file_path = File.expand_path("../help", __FILE__)
    File.read(file_path)
  end
end
