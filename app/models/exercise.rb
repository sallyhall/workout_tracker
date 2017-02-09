class Exercise < ActiveRecord::Base
	validates :name, presence: true
	has_many :exercise_equipments
	has_many :equipment, through: :exercise_equipments
	has_many :workout_exercises
	has_many :workouts, through: :workout_exercises

	filterrific(
		available_filters: [
			:search_query,
			:with_equipment_id
		]
	)

	scope :with_equipment_id, lambda { |equipment_id|
	  where(equipment: { id: equipment_id }).joins(:equipment)
	}

	scope :search_query, lambda { |query|
		return nil if query.blank?

		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e|
			(e.gsub('*', '%') + '%').gsub(/%+/, '%')
		}
		num_or_conds = 2
		where(
		    terms.map { |term|
		      "(LOWER(exercise.name) LIKE ? OR LOWER(exercise.description) LIKE ?)"
		    }.join(' AND '),
		    *terms.map { |e| [e] * num_or_conds }.flatten
		  )
	}

	scope :without_equipment, lambda {
		where(equipment_ids.length == 0)
	}
end
