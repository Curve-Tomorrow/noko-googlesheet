class AddEnabledToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :enabled, :boolean
  end
end
