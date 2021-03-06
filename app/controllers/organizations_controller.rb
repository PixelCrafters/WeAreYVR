class OrganizationsController < ApplicationController  
  before_filter :check_if_signed_in, only: [:claim, :edit, :toggle_hiring, :destroy_tag, :add_role, :destroy_role]
  after_filter :unset_original_url, only: [:claim]
  before_filter :find_organization, only: [:show, :claim, :edit, :update, :toggle_hiring, :add_role, :upload_image]

  def index
    @organizations = Organization.all.order("updated_at DESC").page(params[:page])
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization::Create.call(organization_params.merge!(active: true), current_user)
    if @organization.persisted?
      flash[:success] = "The organization was added successfully"
    else
      flash[:danger] = "There was a problem adding your organization"
    end
    redirect_to [:edit, @organization]
  end

  def claim
    if @organization.claimed?
      redirect_to user_path(@organization, current_user)
    else
      @organization = Organization::Claim.call(current_user, @organization)
      if @organization.claimed?
        flash[:success] = "The organization was claimed successfully"
        redirect_to user_path(current_user)
      else
        redirect_to @organization
      end
    end
  end

  def upload_image
    @organization.image = params[:image]
    if params[:image] && @organization.save!
      flash[:success] = "Your image was successfully saved!"
      redirect_to @organization
    else
      flash[:danger] = "We had a problem saving your image."
      redirect_to edit_organization_path @organization
    end
  end

  def edit
    @profile_link = ProfileLink.new(:linkable => @organization)
    @address = @organization.main_address || Address.new
  end

  def update
    if @organization.update!(organization_params)
      flash[:success] = "The organization was updated successfully"
    else
      flash[:danger] = "There was a problem updating your organization"
    end
    redirect_to edit_organization_path(@organization)
  end

  def toggle_hiring
    if params[:hiring] == "false"
      @organization.update(hiring: true)
      @organization.create_activity key: "organization.hiring", owner: current_user
    else
      @organization.update(hiring: false)
      @organization.create_activity key: "organization.not_hiring", owner: current_user
    end
    redirect_to edit_organization_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.friendly.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:claimed, :user_id, :headline, :description, :name, :hiring_roles, :why_vancouver, :number_of_employees, :neighbourhood, :hiring_url, :hiring)
  end
end
