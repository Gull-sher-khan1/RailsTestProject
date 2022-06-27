# frozen_string_literal: true

module UsersHelper
  def get_request(profile_user_id, current_user_id)
    Following.get_request(profile_user_id, current_user_id)
  end
end
