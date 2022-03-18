# frozen_string_literal: true

class TimeEntry
  attr_accessor :spent_date
  attr_accessor :hours
  attr_accessor :billable

  def initialize(api_response = nil)
    if api_response
      self.spent_date = api_response["spent_date"]&.then { |s| Date.parse(s) }
      self.hours = api_response["hours"]
      self.billable = api_response["billable"]
    end
  end
end
