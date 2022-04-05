# frozen_string_literal: true

# == Schema Information
#
# Table name: unworked_days
#
#  id     :bigint           not null, primary key
#  day    :date             not null
#  reason :string
#
class UnworkedDay < ApplicationRecord
  validates :day, uniqueness: true
end
