class ExerciseEquipment < ActiveRecord::Base
	belongs_to :equipment
	belongs_to :exercise
end
