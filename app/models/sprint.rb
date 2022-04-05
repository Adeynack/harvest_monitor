# frozen_string_literal: true

# == Schema Information
#
# Table name: sprints
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  during_from :date             not null
#  during_to   :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Sprint < ApplicationRecord
  def days
    (during_from..during_to).to_a
  end

  def worked_days
    (days - unworked_days).filter(&:on_weekday?)
  end

  def unworked_days
    @unworked_days ||= UnworkedDay.where(day: during_from..during_to).pluck(:day)
  end

  class << self
    def find_for_date(date)
      find_by("during_from <= :day AND during_to >= :day", day: date)
    end

    def current
      find_for_date(Date.current)
    end
  end
end
