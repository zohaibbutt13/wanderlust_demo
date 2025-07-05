class CreateProjectsVideos < ActiveRecord::Migration[7.2]
  def change
    create_table :projects_videos do |t|
      t.references :project
      t.references :video
    end
  end
end
