class AddIsPrivateToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :private, :boolean
  end
end
