# frozen_string_literal: true

class UniqueIndexOnDayForUnworkedDay < ActiveRecord::Migration[7.0]
  def change
    add_index :unworked_days, :day, unique: true
  end
end
