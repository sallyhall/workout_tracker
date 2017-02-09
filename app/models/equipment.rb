class Equipment < ActiveRecord::Base
	validates :name, presence: true
	has_many :exercise_equipments
	has_many :exercises, through: :exercise_equipments

	def self.options_for_select
	  order('LOWER(name)').map { |e| [e.name, e.id] }
	end
end

