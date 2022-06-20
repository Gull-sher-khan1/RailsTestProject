class ChangeRequestToBool < ActiveRecord::Migration[5.2]
  def change
    change_table :followings do |t|
      change_column :followings, :request_accepted, 'boolean USING CAST(request_accepted AS boolean)'
    end
  end
end
