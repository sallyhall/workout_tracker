class Exercise < ActiveRecord::Base
	validates :name, presence: true
	has_many :exercise_equipments
	has_many :equipment, through: :exercise_equipments
	has_many :workout_exercises
	has_many :workouts, through: :workout_exercises

	filterrific(
		default_filter_params: {sorted_by: 'name'},
		available_filters: [
			:sorted_by,
			:search_query,
			:with_equipment_id
		]
	)

	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		when /^name/
			order("LOWER(name) #{ direction }")
		when /^description/
			order("LOWER(description) #{ direction }")
		else
    		raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    	end
	}

	scope :with_equipment_id, lambda { |equipment_ids|
		where(equipment_id: [*equipment_ids])
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
		      "(LOWER(name) LIKE ? OR LOWER(description) LIKE ?)"
		    }.join(' AND '),
		    *terms.map { |e| [e] * num_or_conds }.flatten
		  )
	}

	scope :without_equipment, lambda {
		where(equipment_ids.length == 0)
	}

	def self.options_for_sorted_by
		[
		  ['Name (a-z)', 'name_asc'],
		  ['Equipment (a-z)', 'equipment_name_asc']
		]
	end
end
