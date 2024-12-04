class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @animals = Animal.all
    @markers = @animals.geocoded.map do |animal|
      {
        lat: animal.latitude,
        lng: animal.longitude
      }
    end
  end

  def show
    @animal = Animal.find(params[:id])
  end

  def new
    @animal = Animal.new()
  end

  def create
    @animal = current_user.animals.new(animal_params)

    @available_start = Date.parse(params[:animal][:available_start])
    @available_end = Date.parse(params[:animal][:available_end])
    if @available_start && @available_end
      if Date.today >= @available_start && Date.today <= @available_end
        @animal.availability = true
      else
        @animal.availability = false
      end
      raise
    else
      @animal.availability = false
    end
    if @animal.save
      @animal.photos.attach(params[:animal][:photos]) if params[:animal][:photos]
      redirect_to animal_path(@animal)
    else
      @animal
      flash.now[:alert] = "There was an error adding the animal."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def update
    @animal = Animal.find(params[:id])

    @available_start = params[:animal][:available_start].present? ? Date.parse(params[:animal][:available_start]) : nil
    @available_end = params[:animal][:available_end].present? ? Date.parse(params[:animal][:available_end]) : nil

    if @available_start && @available_end
      @animal.availability = Date.today >= @available_start && Date.today <= @available_end
    else
      @animal.availability = false
    end

    if @animal.update(animal_params)
      redirect_to animal_path(@animal), notice: "Animal listing updated successfully."
    else
      flash.now[:alert] = "There was an error updating the animal listing."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def authorize_user!
    @animal = Animal.find(params[:id])
    unless @animal.user == current_user
      redirect_to animals_path, alert: "You are not authorized to edit this listing."
    end
  end

  def animal_params
    params.require(:animal).permit(:name, :species, :age, :price, :availability, :address, :description, photos: [])
  end
end
