module Payroll
  PAYDAYS        = [6, 21]
  PAY_PERIOD_ONE = [1, 15]
  PAY_PERIOD_TWO = [16,-1]

  def paydays(numbers=PAYDAYS)
    numbers.map do |payday_number|
      payday = Date.new(@date.year, @date.month, payday_number)
      payday - 1 if payday.saturday?
      payday - 2 if payday.sunday?
      payday
    end
  end

  def pay_periods(one=PAY_PERIOD_ONE, two=PAY_PERIOD_TWO)
    args = method(__method__).parameters.map { |_, arg| binding.local_variable_get(arg) }
    args.map do |arg|
      to_date_obj(arg)
    end
  end

  def processing_days
    processing_days = []
    pay_periods.each do |pay_period|
      day_one = pay_period[1] + 1
      day_two = pay_period[1] + 2
      days    = [day_one, day_two]
      processing_days.push(days)
    end
    processing_days.map do |days|
      add_until_weekdays(days)
    end
  end

  def timesheet_due_dates
    first = Date.new(@date.year, @date.month, PAY_PERIOD_ONE[1])
    last  = Date.new(@date.year, @date.month, PAY_PERIOD_TWO[1])
    dates = [first, last]
    subtract_until_weekdays(dates)
  end

  private

  def to_date_obj(days)
    days.map do |day|
      Date.new(@date.year, @date.month, day)
    end
  end

  def add_until_weekdays(days)
    add_to_last   = 2 if days[0].friday?
    add_to_both   = 2 if days[0].saturday?
    add_to_both   = 1 if days[0].sunday?
    days[1]      += add_to_last if add_to_last

    days.map! {|day| day += add_to_both} if add_to_both
    days
  end

  def subtract_until_weekdays(days)
    days.map do |day|
      num = 1 if day.saturday?
      num = 2 if day.sunday?
      num = 3 if day == days[0] && day.monday?
      day-= num if num
      day
    end
  end

end
