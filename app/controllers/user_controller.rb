class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_role, :remove_role]

  def add_role
    @user.add_role params[:role]
    redirect_to @user, notice: "Role #{params[:role]} added to user."
  end

  def remove_role
    @user.remove_role params[:role]
    redirect_to @user, notice: "Role #{params[:role]} removed from user."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
