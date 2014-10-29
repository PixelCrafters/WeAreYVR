class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_filter :deny_access, unless: :org_admin?, only: [:edit, :destroy]

  def index
    @jobs = Job.all
  end

  def new
    @current_user = current_user
    @job = Job.new
  end

  def edit
    @current_user = current_user
  end

  def create
    @job = Job.new job_params
    if @job.save
      flash[:success] = "Thanks! We have received your job posting. We'll review it and publish as soon as possible."
      redirect_to jobs_url
    else
      render :new
    end
  end

  def update
    if @job.update job_params
      flash[:success] = 'Job was successfully updated.'
      redirect_to edit_job_url @job
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    flash[:success] = 'Job was successfully destroyed.'
    redirect_to jobs_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      begin
        @job = Job.find params[:id]
      rescue ActiveRecord::RecordNotFound => e
        not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description, :want_junior, :want_intermediate, :want_senior, :want_executive, :job_type, :link, :organization_id)
    end

    def org_admin?
      current_user && current_user.organizations.include?(@job.organization)
    end

    def deny_access
      redirect_to jobs_url
    end
end
