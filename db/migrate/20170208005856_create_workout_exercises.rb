class CreateWorkoutExercises < ActiveRecord::Migration
  def change
    create_table :workout_exercises do |t|
      t.integer :workout_id, null: false
      t.integer :exercise_id, null: false
      t.timestamps null: false
    end
  end
end
