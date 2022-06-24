# frozen_string_literal: true

module ApplicationHelper
  def flash_helper(msg,name)
    flash[name] = msg
    flash.keep
    p flash
    root_url
  end
end
