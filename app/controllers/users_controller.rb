class UsersController < ApplicationController
  before_filter :check_session, only: [:edit, :update, :toggle_email_digest_subscription, :upload_image]
  before_filter :sign_in_before_claim, only: [:claim]

  def index
    @users = User.all.order("updated_at DESC").page(params[:page])
  end

  def show
    begin
      @user = User.find(params[:id])
    rescue
      ActiveRecord::RecordNotFound
      flash[:danger] = "That user does not exist"
      redirect_to root_url
    end
  end

  def edit
    @user = current_user
    @profile_link = ProfileLink.new(:linkable => @user)
  end

  def update
    @user = current_user
    if @user.email.nil? && params[:user][:email].present?
      SendVerificationEmail.call(params[:user][:email], @user, session[:current_connection])
      @user.update(user_params)
      redirect_to user_path(@user)
    else
      @user.update(user_params)
      redirect_to edit_user_path(@user)
    end
  end

  def toggle_email_digest_subscription
    if current_user.email_digest?
      current_user.update(email_digest: false)
    else
      current_user.update(email_digest: true)
    end
    redirect_to edit_user_path(current_user)
  end

  def unsubscribe
    if user = User.read_access_token(params[:signature])
      user.update(email_digest: false)
      flash[:success] = "You have been unsubscribed"
    else
      flash[:danger] = "Invalid Link"
    end
    redirect_to root_path
  end

  def claim
    @user = User.find(params[:id])
    if @user.email.nil?
      flash[:danger] = "You already have a profile."
    else
      if @user.update!(claimed: true)
        flash[:success] = "You have been successfully claimed this profile"
      else
        flash[:danger] = "The profile could not be claimed"
      end
    end
    session[:claimed_user_id] = nil
    redirect_to @user
  end

  def upload_image
    @user = User.find(params[:id])
    @user.image = params[:image]
    if params[:image] && @user.save!
      flash[:success] = "Your image was successfully saved!"
      redirect_to @user
    else
      flash[:danger] = "We had a problem saving your image."
      redirect_to edit_user_path @user
    end
  end

  private

  def sign_in_before_claim
    user = User.find(params[:id])
    if current_user.nil?
      session[:original_url] = request.original_url
      session[:claimed_user_id] = user.id
      redirect_to login_path
      return
    end
  end

  def check_session
    redirect_to unset_session_path if session[:expires_at] < Time.current
  end

  def user_params
    params.require(:user).permit(:email, :name, :bio, :short_bio, :why_vancouver)
  end
end
