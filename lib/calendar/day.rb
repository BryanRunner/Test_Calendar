class Day < Calendar
  attr_accessor :name
  attr_accessor :date
  attr_accessor :number

  def initialize(date=DATE)
    @date   = date
    @name   = @date.strftime("%A")
    @number = @date.mday
  end
end
