class Exercise < ActiveRecord::Base
	has_many :equipments, through: :exercise_equipment
	has_many :workouts, through: :workout_exercise
end
