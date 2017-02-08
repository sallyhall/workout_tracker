class EquipmentsController < ApplicationController
	def show
		@equipment = Equipment.find(params[:id])
	end

	def index
		@equipments = Equipment.all
	end

	def new 
	end

	def create
		@equipment = Equipment.new(equipment_params)

		@equipment.save
		redirect_to @equipment
	end

	private

	def equipment_params
		params.require(:equipment).permit(:name, :description)
	end
end
