# run with:
# rails runner ./script/download_web_images.rb
users = User.where("image like ?", "%http%")
puts "Users with existing images: #{users.count}"
count = 0
users.each do |user|
  count += 1
  puts count if count % 25 == 0
  remote = user.read_attribute_before_type_cast('image')
  begin
    user.remote_image_url = remote
    user.save!
  rescue
    puts "Error with URL: #{remote}"
  end
end
puts count

puts "\n\n"

organizations = Organization.where("image like ?", "%http%")
puts "Organizations with existing images: #{organizations.count}"
count = 0
organizations.each do |organization|
  count += 1
  puts count if count % 25 == 0
  remote = organization.read_attribute_before_type_cast('image')
  begin
    organization.remote_image_url = remote
    organization.save!
  rescue
    puts "Error with URL: #{remote}"
  end
end
puts count
