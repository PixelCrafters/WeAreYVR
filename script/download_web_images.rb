# run with:
# rails runner ./script/download_web_images.rb
puts User.all.count
User.where("image like ?", "%http%").each do |user|
  web_url = user.image_url
  web_url = web_url[web_url.index('http')..-1]
  puts web_url
  # file << open(web_url).read
  # user.image = file
  # user.save!
end
