class Equipment < ActiveRecord::Base
	has_many :exercises, through: :exercise_equipment
end
