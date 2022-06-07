class UsersController < ApplicationController
  layout 'navbar'
  def show
    @user=User.find(params[:id])
  end
end
