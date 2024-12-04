class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]
  before_action :set_animal, only: [:show, :destroy]

  def index
    @animals = Animal.all
    @markers = @animals.geocoded.map do |animal|
      {
        lat: animal.latitude,
        lng: animal.longitude
      }
    end
  end

  def my_listings
    @animals = current_user.animals
  end

  def show
    # empty
  end

  def new
    @animal = Animal.new()
  end

  def create
    @animal = current_user.animals.new(animal_params)

    if @animal.available_start.present? && @animal.available_end.present?
      @animal.availability = Date.today >= @animal.available_start && Date.today <= @animal.available_end
    else
      @animal.availability = false
    end

    if @animal.save
      @animal.photos.attach(params[:animal][:photos]) if params[:animal][:photos]
      redirect_to animal_path(@animal), notice: "Animal created successfully."
    else
      flash.now[:alert] = "There was an error creating the animal."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def update
    @animal = Animal.find(params[:id])

    if params[:animal][:photos].present?
      params[:animal][:photos].each do |photo|
        @animal.photos.attach(photo)
      end
    end

    @animal.assign_attributes(animal_params.except(:photos))

    if @animal.available_start.present? && @animal.available_end.present?
      @animal.availability = Date.today >= @animal.available_start && Date.today <= @animal.available_end
    else
      @animal.availability = false
    end

    if @animal.update(animal_params.except(:photos))
      redirect_to animal_path(@animal), notice: "Animal listing updated successfully."
    else
      flash.now[:alert] = "There was an error updating the animal listing."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @animal.destroy
    redirect_to my_listings_path, status: :see_other
  end

  private

  def authorize_user!
    @animal = Animal.find(params[:id])
    unless @animal.user == current_user
      redirect_to animals_path, alert: "You are not authorized to edit this listing."
    end
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :species, :age, :price, :availability, :address, :description, :available_start, :available_end, photos: [])
  end
end
