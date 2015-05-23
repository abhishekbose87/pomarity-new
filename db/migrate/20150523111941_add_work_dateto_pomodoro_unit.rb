class AddWorkDatetoPomodoroUnit < ActiveRecord::Migration
  def change
    add_column :pomodoro_units, :work_date, :date unless column_exists? :pomodoro_units, :work_date
  end
end
