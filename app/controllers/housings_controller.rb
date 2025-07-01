class HousingsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @locations = Housing.select(:location).distinct.pluck(:location)
    @housings = policy_scope(Housing)

    # Show unpublished housings first
    @housings = @housings.order(published: :asc)

    @housings = @housings.where(location: params[:location]) if params[:location].present?
    @housings = @housings.order(price: (params[:sort] == "desc" ? :desc : :asc)) if params[:sort].present?
  end

  def show
    @housing = Housing.find(params[:id])
    authorize @housing
  end

  def new
    @housing = Housing.new
    authorize @housing
  end

  def create
    @housing = current_user.housings.build(housing_params)
    authorize @housing

    if @housing.save
      redirect_to housings_path, notice: "Locuință adăugată!"
    else
      render :new
    end
  end

  def publish
    @housing = Housing.find(params[:id])
    authorize @housing

    @housing.update(published: true)
    redirect_to housings_path, notice: "Locuința a fost publicată."
  end

  private

  def housing_params
    params.require(:housing).permit(:title, :description, :price, :location, images: [])
  end
end
