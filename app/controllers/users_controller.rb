class UsersController < ApplicationController
  def create
    User.create params[:user]
  end
end
