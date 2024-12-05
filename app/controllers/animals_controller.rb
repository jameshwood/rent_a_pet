class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]
  before_action :set_animal, only: [:show, :destroy]

  def index
    if user_signed_in?
      @animals = Animal.where.not(user: current_user)
    else
      @animals = Animal.all
    end

    @markers = @animals.geocoded.map do |animal|
      {
        lat: animal.latitude,
        lng: animal.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {animal: animal})
      }
    end
  end

  def search
    location = params[:search][:location]
    from_date = Date.parse(params[:search][:from]) rescue nil
    to_date = Date.parse(params[:search][:to]) rescue nil
    animal_type = params[:search][:animal_type]

    @animals = Animal.all

    if location.present?
      coordinates = Geocoder.search(location).first&.coordinates
      if coordinates
        @animals = @animals.near(coordinates, 10) # 10km radius
      end
    end

    if from_date && to_date
      @animals = @animals.where("available_start <= ? AND available_end >= ?", from_date, to_date)
    end

    @animals = @animals.where(species: animal_type) if animal_type.present?

    @markers = @animals.geocoded.map do |animal|
      {
        lat: animal.latitude,
        lng: animal.longitude,
        info_window_html: render_to_string(partial: "animals/info_window", locals: { animal: animal })
      }
    end
    render :search
  end


  def my_listings
    @animals = current_user.animals
  end

  def show
    # empty
    @marker = {
      lat: @animal.latitude,
      lng: @animal.longitude,
      info_window_html: render_to_string(partial: "animals/info_window", locals: { animal: @animal })
    }
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

  def destroy_photo
    @animal = Animal.find(params[:id])
    photo = @animal.photos.find(params[:photo_id])
    photo.purge
    redirect_to edit_animal_path(@animal), notice: "Photo deleted successfully."
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
