class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :FirstName, :first_name
    rename_column :users, :LastName, :last_name
  end
end
