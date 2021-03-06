class TypesController < ApplicationController
  before_filter :find_organization

  def add_to_organization
    type = Type.find(params[:type][:id])
    begin
      @organization.types << type
      flash[:success] = "You've successfully added the type #{type.name}"
    rescue ActiveRecord::RecordNotUnique
      flash[:danger] = "You've already added type #{type.name} to #{@organization.name}"
    end
    redirect_to edit_organization_path(@organization)
  end

  def remove_from_organization
    type = Type.find(params[:type_id])
    @organization.types.delete(type)
    redirect_to edit_organization_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end
end
