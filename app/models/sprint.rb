# frozen_string_literal: true

# == Schema Information
#
# Table name: sprints
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  during              :daterange        not null
#  weekdays_not_worked :date             default([]), not null, is an Array
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Sprint < ApplicationRecord
  def worked_days
    (during.to_a - weekdays_not_worked).filter(&:on_weekday?)
  end

  class << self
    def find_for_date(date)
      find_by("during @> ?::date", date)
    end

    def current
      find_for_date(Date.current)
    end
  end
end
