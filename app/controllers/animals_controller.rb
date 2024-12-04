class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_animal, only: [:show, :destroy]

  def index
    @animals = Animal.all
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
      @animal.availability = Date.today >= @available_start && Date.today <= @available_end
    else
      @animal.availability = false
    end
    if @animal.save
      redirect_to animal_path(@animal)
    else
      @animal
      flash.now[:alert] = "There was an error adding the animal."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    raise
    @animal.destroy
    redirect_to my_listings_path, status: :see_other
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :species, :age, :price, :availability, :description, photos: [])
  end
end
