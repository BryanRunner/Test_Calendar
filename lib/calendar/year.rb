class Year < Calendar
  attr_accessor :number
  attr_accessor :date
  attr_accessor :months

  def initialize(date=DATE)
    @date   = date
    @number = date.year
    @months = create_months
    assign_months(@months)
  end

end
