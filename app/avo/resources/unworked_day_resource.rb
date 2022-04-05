# frozen_string_literal: true

class UnworkedDayResource < Avo::BaseResource
  self.title = :id
  self.includes = []

  field :id, as: :id
  field :day, as: :date, required: true, sortable: true
  field :reason, as: :text, sortable: true
end
