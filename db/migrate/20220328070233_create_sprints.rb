# frozen_string_literal: true

class CreateSprints < ActiveRecord::Migration[7.0]
  def change
    create_table :sprints do |t|
      t.string :name, null: false
      t.date :during_from, null: false
      t.date :during_to, null: false
      t.timestamps
    end

    create_table :unworked_days do |t|
      t.date :day, null: false
    end
  end
end
