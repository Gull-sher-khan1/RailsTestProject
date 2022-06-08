class ChangeRequestDataType < ActiveRecord::Migration[5.2]
  def change
    change_table :followings do |t|
      t.change :request_accepted, :string
    end
  end
end
