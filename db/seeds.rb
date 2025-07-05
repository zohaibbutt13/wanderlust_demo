# Creating Clients
if !Client.any?
  Client.create!(full_name: 'Itachi Uchiha', email: 'itachi_uchiha@gmail.com')
  Client.create!(full_name: 'Asta', email: 'asta@gmail.com')
  Client.create!(full_name: 'Jiraiya', email: 'jiraiya@gmail.com')
end

# Creating Users
if !User.any?
  User.create!(full_name: 'John Doe', email: 'johndoe@gmail.com', role: 'user')
  User.create!(full_name: 'Zeeshan Syed', email: 'zeeshansyed@gmail.com', role: 'project_manager')
  User.create!(full_name: 'Steve Smith', email: 'stevesmith@gmail.com', role: 'project_manager')
end

# Creating Videos
if !Video.any?
  video1_path = video_path = Rails.root.join('app', 'assets', 'videos', 'teaser.mp4')
  video1 = Video.create!(title: 'Teaser', description: 'A Teaser for your provided footage')
  video1.file.attach(io: File.open(video1_path), filename: 'Teaser.mp4')

  video2_path = video_path = Rails.root.join('app', 'assets', 'videos', 'reel.mp4')
  video2 = Video.create!(title: 'Reel', description: 'A Reel for your provided footage')
  video2.file.attach(io: File.open(video2_path), filename: 'Reel.mp4')

  video3_path = video_path = Rails.root.join('app', 'assets', 'videos', 'highlights.mp4')
  video3 = Video.create!(title: 'Highlights', description: 'A Highlights for your provided footage')
  video3.file.attach(io: File.open(video3_path), filename: 'Highlights.mp4')
end

# Creating Projects
if !Project.any?
  client = Client.find_by(email: 'jiraiya@gmail.com')
  user = User.where(role: 'project_manager').first
  project1 = client.projects.create!(title: 'Porject 1', footage_link: 'https://www.abc.com', status: 'pending', user_id: user.id)
  video = Video.first
  project1.projects_videos.create!(video_id: video.id)
  video = Video.last
  project1.projects_videos.create!(video_id: video.id)

  user = User.where(role: 'project_manager').last
  project2 = client.projects.create!(title: 'Porject 2', footage_link: 'https://www.xyz.com', status: 'in_progress', user_id: user.id)
  Video.first(3).each do |v|
    project2.projects_videos.create!(video_id: v.id)
  end

  client = Client.find_by(email: 'itachi_uchiha@gmail.com')
  project3 = client.projects.create!(title: 'Porject 3', footage_link: 'https://www.qwe.com', status: 'in_progress', user_id: user.id)
  video = Video.first
  project3.projects_videos.create!(video_id: video.id)
end
