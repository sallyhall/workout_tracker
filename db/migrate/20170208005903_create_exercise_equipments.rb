class CreateExerciseEquipments < ActiveRecord::Migration
  def change
    create_table :exercise_equipments do |t|
      t.integer :equipment_id, null: false
      t.integer :exercise_id, null: false

      t.timestamps null: false
    end
  end
end
