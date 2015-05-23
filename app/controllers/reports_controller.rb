class ReportsController < ApplicationController

  def index
    # Project.all.each do |project|
    #   name = project.name.downcase
    #   project.pomodoro_units.group("pomodoro_units.work_date").select("count(*) as #{name}, pomodoro_units.work_date as date").to_jsvar(name)
    # end

    PomodoroUnit.joins(:project).group("pomodoro_units.work_date").select(
      "count(CASE WHEN projects.name = 'Mesitis' THEN 1 END) as mesitis,
       count(CASE WHEN projects.name = 'Learning' THEN 1 END) as learning,
       count(CASE WHEN projects.name = 'Others' THEN 1 END) as others,
       count(CASE WHEN projects.name = 'Clicksome' THEN 1 END) as clicksome,
       pomodoro_units.work_date as date"
      ).order("date asc").to_jsvar(:pomodoro_units)
  end
end
