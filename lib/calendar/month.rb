class Month < Calendar
  attr_accessor :number
  attr_accessor :date
  attr_accessor :name
  attr_accessor :days

  def initialize(date=DATE)
    @date       = date
    @number     = date.month
    @name       = date.strftime("%B")
    @days       = create_days(self)
  end

  def total_days
    # returns Fixnum of total days in month
    Date.new(@date.year, @date.month, -1).day
  end

  def days_left
    # returns Fixnum of days left in month
    total_days - @date.day
  end

  def day(number)
    # accepts Fixnum, returns day object associated with day number of month
    @days[number - 1]
  end

end
