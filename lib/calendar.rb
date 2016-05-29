require 'date'
require 'calendar/payroll'

class Calendar
  include Payroll
  DATE = Date.today

  def initialize(date=DATE)
    @date = date
    create_year
    assign_months(year.months)
  end

  def create_year(date=@date, name="year")
    year = Year.new(date)
    singleton_class.class_eval { attr_accessor "#{name}" }
    send("#{name}=", year)
  end

  def create_months(start_month=1, end_month=12)
    m = start_month
    months = []
    while m <= end_month
      date  = Date.new(@date.year, m, 1)
      month = Month.new(date)
      months.push(month)
      m+= 1
    end
    months
  end

  def create_days(month)
    d = 1
    days = []
    while d <= month.total_days
      date = Date.new(@date.year, month.number, d)
      day = Day.new(date)
      days.push(day)
      d+= 1
    end
    days
  end

  def month(month=@date.month)
    # accepts month name as a String or the month number as a Fixnum, if no arguments are passed defaults to current month
    if month.is_a? Fixnum
      month = Date.new(@date.year, month, 1).strftime("%B").downcase
    end
    self.send(month)
  end

  def day(month=self.month, day_number=@date.day)
    month.days[day_number - 1]
  end

  def humanize(date=@date)
    case self
    when Year
      date.strftime("%Y")
    when Month
      date.strftime("%B")
    when Day
      date.strftime("%A")
    when Calendar
      date.strftime("%A %b %-d %Y")
    end
  end

  private

  def assign_months(months)
    months.each do |month|
      singleton_class.send(:define_method, month.name.downcase) do
        month
      end
    end
  end

end

require 'calendar/day'
require 'calendar/year'
require 'calendar/month'
