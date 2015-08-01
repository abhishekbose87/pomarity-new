class FileController < ApplicationController
  include SimpleCaptcha::ControllerHelpers

  def upload_form
  end

  def pomodoro_upload
    if params["pomodoro_upload_file"].present? && simple_captcha_valid?
      uploaded_io = params["pomodoro_upload_file"]
      file_path = Rails.root.join('public', 'uploads', 'pomodoro_upload_file.json')

      File.open(file_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end

      file = File.read(file_path)
      data_hash = JSON.parse(file)

      remove_projects
      remove_pomodoro_units

      load_projects(data_hash["projects"])
      load_pomodoro_units(data_hash["workUnits"])

      redirect_to root_path, notice: "Data successfully uploaded"
    else
      redirect_to upload_form_path, notice: "Please fill form correctly"
    end
  end

  private

  def remove_projects
    Project.destroy_all
  end

  def remove_pomodoro_units
    PomodoroUnit.destroy_all
  end

  def load_projects(projects)
    projects.each do |project|
      Project.create(name: project["_n"], id: project["_id"])
    end
  end

  def load_pomodoro_units(work_units)
    work_units.each do |work_unit|
      start_datetime = DateTime.parse(Time.at(work_unit["_t"]).to_s)
      end_datetime = start_datetime + 25.minutes
      PomodoroUnit.create(start_datetime: start_datetime, id: work_unit["_id"], end_datetime: end_datetime, project_id: work_unit["_p"], work_date: work_unit["_dt"])
    end
  end

end
