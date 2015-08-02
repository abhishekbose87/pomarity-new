class ReportsController < ApplicationController

  def index
    if PomodoroUnit.count > 0
      PomodoroUnit.joins(:project).group("pomodoro_units.work_date").select(
        "#{case_query},
         pomodoro_units.work_date as date"
        ).order("date asc").to_jsvar(:pomodoro_units)
    else
      redirect_to upload_form_path
    end
  end

  private

  def case_query
    case_statements_array = []
    Project.all.each do |project|
      case_statements_array << "count(CASE WHEN projects.name = '#{project.name}' THEN 1 END) as #{project.name}"
    end
    case_statements_array.join(", ")
  end

end
