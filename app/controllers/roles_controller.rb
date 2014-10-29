class RolesController < ApplicationController
  def index
    @roles = Role.all.order("name DESC").page(params[:page])
  end

  def show
    begin
      @role = Role.find(params[:id])
      @users = @role.users
    rescue
      ActiveRecord::RecordNotFound
      flash[:danger] = "That role does not exist"
      redirect_to root_url
    end
  end
end
