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

  def during_from
    during&.min
  end

  def during_from=(from)
    self.during = from.to_date..during_to
  end

  def during_to
    during&.max
  end

  def during_to=(to)
    self.during = during_from..to.to_date
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
