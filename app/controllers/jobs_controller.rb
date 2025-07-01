# app/controllers/jobs_controller.rb
class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update destroy]

  def index
    @categories = Job.distinct.pluck(:category)
    @jobs = policy_scope(Job)
    @jobs = @jobs.order(published: :asc)

    return unless params.slice(:category, :min_salary).present?

    @jobs = @jobs.filter(params.slice(:category, :min_salary))
  end

  def show; end

  def new
    @job = Job.new
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      redirect_to @job, notice: 'Job creat cu succes.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job actualizat.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: 'Job șters.'
  end

  def publish
    @job = Job.find(params[:id])
    authorize @job

    @job.update(published: true)
    redirect_to housings_path, notice: "Locuința a fost publicată."
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :salary, :category, images: [])
  end
end
