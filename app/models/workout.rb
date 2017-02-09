class Workout < ActiveRecord::Base
	validates :name, presence: true
	has_many :workout_exercises
	has_many :exercises, through: :workout_exercises
end
