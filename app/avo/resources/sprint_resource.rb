# frozen_string_literal: true

class SprintResource < Avo::BaseResource
  self.title = :name
  self.includes = []

  field :id, as: :id
  field :name, as: :text, required: true, sortable: true
  field :during_from, as: :date, required: true, sortable: true
  field :during_to, as: :date, required: true, sortable: true
end
