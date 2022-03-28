# frozen_string_literal: true

class CreateSprints < ActiveRecord::Migration[7.0]
  def change
    create_table :sprints do |t|
      t.string :name, null: false
      t.daterange :during, null: false
      t.date :weekdays_not_worked, array: true, default: [], null: false
      t.timestamps
    end
  end
end
