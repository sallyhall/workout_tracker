class ExercisesController < ApplicationController
	def index
		@filterrific = initialize_filterrific(
			Exercise,
			params[:filterrific],
			select_options: {
				sorted_by: Exercise.options_for_sorted_by,
				with_equipment_id: Equipment.options_for_select
			}
		) or return
		@exercises = @filterrific.find.page(params[:page])

		respond_to do |format|
		    format.html
		    format.js
		end
	end

	def show
		@exercise = Exercise.find(params[:id])
	end

	def new 
		@exercise = Exercise.new
	end

	def edit
		@exercise = Exercise.find(params[:id])
	end

	def create
		@exercise = Exercise.new(exercise_params)

		if @exercise.save
			redirect_to @exercise
		else
			render 'new'
		end
	end

	def update
		@exercise = Exercise.find(params[:id])
		if @exercise.update(exercise_params)
			redirect_to @exercise
		else
			render 'edit'
		end
	end

	def destroy
		@exercise = Exercise.find(params[:id])
		@exercise.destroy

		redirect_to exercises_path
	end

	private

	def exercise_params
		params.require(:exercise).permit(:name, :description, equipment_ids: [])
	end
end
