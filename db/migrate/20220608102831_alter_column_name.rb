class AlterColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :PrivateAccount, :private_account
  end
end
