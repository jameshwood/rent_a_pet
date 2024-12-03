class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @animal = Animal.new()
  end

  def create
    @animal = current_user.animals.new(animal_params)
    if @animal.save
      redirect_to animal_path(@animal)
    else
      @animal
      flash.now[:alert] = "There was an error adding the animal."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :species, :age, :price, :availability, :photos, :description)
  end
end
