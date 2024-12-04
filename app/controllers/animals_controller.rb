class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_animal, only: [:show, :destroy]

  def index
    @animals = Animal.all
    @markers = @animals.geocoded.map do |animal|
      {
        lat: animal.latitude,
        lng: animal.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {animal: animal})
      }
    end
  end

  def search
    # Extract search parameters
    location = params[:search][:location]
    from_date = Date.parse(params[:search][:from]) rescue nil
    to_date = Date.parse(params[:search][:to]) rescue nil
    animal_type = params[:search][:animal_type]

    @animals = Animal.all

    @animals = @animals.where("address ILIKE ?", "%#{location}%") if location.present?

    if from_date && to_date
      @animals = @animals.where("available_start <= ? AND available_end >= ?", from_date, to_date)
    end

    @animals = @animals.where("species ILIKE ?", "%#{animal_type}%") if animal_type.present?

    render :search
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

    @available_start = Date.parse(params[:animal][:available_start])
    @available_end = Date.parse(params[:animal][:available_end])

    if @available_start && @available_end
      if Date.today >= @available_start && Date.today <= @available_end
        @animal.availability = true
      else
        @animal.availability = false
      end
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

  def destroy
    @animal.destroy
    redirect_to my_listings_path, status: :see_other
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :species, :age, :price, :availability, :address, :description, photos: [])
  end
end
