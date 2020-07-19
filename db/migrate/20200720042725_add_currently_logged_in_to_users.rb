class AddCurrentlyLoggedInToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :currently_logged_in, :boolean, default: false
  end
end
