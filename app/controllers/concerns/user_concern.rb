# frozen_string_literal: true

module UserConcern
  extend ActiveSupport::Concern

  def set_users(objects)
    @user_ids = objects.distinct.pluck('user_id')
    @users = User.find(@user_ids)
  end
end
