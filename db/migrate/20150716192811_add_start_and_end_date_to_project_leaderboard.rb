class AddStartAndEndDateToProjectLeaderboard < ActiveRecord::Migration[6.0]
  def change
    add_column :project_leaderboards, :start_date, :date
    add_column :project_leaderboards, :end_date, :date
  end
end
