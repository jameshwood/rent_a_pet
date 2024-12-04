class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]
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

    if @animal.available_start.present? && @animal.available_end.present?
      @animal.availability = Date.today >= @available_start && Date.today <= @available_end
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
