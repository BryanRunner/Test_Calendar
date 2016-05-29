# NOTE this module is a bit sloppy, could use some DRYing up and refactoring.
# also should return Date objects if it were ever to be used in a real application
module Payroll
  PAYDAYS = [6,21]
  PROCESSING = { first_pay_period: [1, 2], second_pay_period: [16, 17] }

  def paydays(numbers=PAYDAYS)
    numbers.map do |payday_number|
      payday = Date.new(@date.year, @date.month, payday_number)

      if payday.saturday?
        (payday - 1).strftime("%A %b %-d %Y")
      elsif payday.sunday?
        (payday - 2).strftime("%A %b %-d %Y")
      else
        payday.strftime("%A %b %-d %Y")
      end

    end
  end

  def process_days(processing=PROCESSING)
    processing.map do |key, value|
      first = Date.new(@date.year, @date.month, value[0])
      second = Date.new(@date.year, @date.month, value[1])

      if first.friday?
        second+= 2
      elsif first.saturday?
        first+= 2
        second+= 2
      elsif first.sunday?
        first+= 1
        second+= 1
      end
      value = [first, second]
      {key => value}
    end
  end

  def timesheet_due_dates(processing=PROCESSING)
    first = Date.new(@date.year, @date.month, processing[:second_pay_period][0])
    second = Date.new(@date.year, @date.month, -1)

    days = [first, second]
    days.map! do |day|
      if day.saturday?
        day-= 1
      elsif day.sunday?
        day-= 2
      elsif day == days[0] && day.monday?
        day-= 3
      end
      day.strftime("%A %b %-d %Y")
    end
    days
  end

end
