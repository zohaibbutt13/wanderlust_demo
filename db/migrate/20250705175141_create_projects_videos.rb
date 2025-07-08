class CreateProjectsVideos < ActiveRecord::Migration[7.2]
  def change
    create_table :projects_videos do |t|
      t.references :project, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end

    add_index :projects_videos, [ :project_id, :video_id ], unique: true
  end
end
