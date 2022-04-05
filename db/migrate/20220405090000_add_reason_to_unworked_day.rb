# frozen_string_literal: true

class AddReasonToUnworkedDay < ActiveRecord::Migration[7.0]
  def change
    add_column :unworked_days, :reason, :string
  end
end
