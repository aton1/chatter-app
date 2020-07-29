class RenameCurrentlyLoggedInToActive < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :currently_logged_in, :active
  end
end
