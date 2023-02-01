# frozen_string_literal: true

class UnworkedDayResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  self.resolve_query_scope = ->(model_class:) do
    model_class.order(day: :desc)
  end

  field :id, as: :id
  field :day, as: :date, required: true, sortable: true
  field :reason, as: :text, sortable: true
end
