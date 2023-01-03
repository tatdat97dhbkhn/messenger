# frozen_string_literal: true

return if User.first.present?

users_avatar_paths = Dir['app/assets/images/users/*']

users_avatar_paths.each do |path|
  file_name = File.basename(path)
  name = file_name.split('.').first

  user = User.new(name: name.titleize, password: '12345678', email: "#{name}@gmail.com")

  user.avatar.attach(
    io: File.open(path),
    filename: file_name,
    content_type: 'image/gif'
  )
  user.not_broadcast = true

  user.save
  user.confirm
end
