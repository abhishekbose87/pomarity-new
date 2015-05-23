class CreatePomodoroUnits < ActiveRecord::Migration
  def change
    create_table :pomodoro_units do |t|
      t.datetime     "start_datetime"
      t.datetime     "end_datetime"
      t.integer      "project_id"
      t.timestamps
    end
  end
end
