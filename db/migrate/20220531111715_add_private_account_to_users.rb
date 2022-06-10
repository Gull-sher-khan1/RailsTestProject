class AddPrivateAccountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :PrivateAccount, :boolean
  end
end
