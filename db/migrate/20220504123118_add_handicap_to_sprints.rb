# frozen_string_literal: true

class AddHandicapToSprints < ActiveRecord::Migration[7.0]
  def change
    add_column :sprints, :handicap_worked, :float, null: false, default: 0.0
    add_column :sprints, :handicap_billable, :float, null: false, default: 0.0
  end
end
