# db/seeds.rb
tags = ['数学', '英語', '受験勉強', 'テスト勉強', '資格試験']

tags.each do |tag_name|
  Tag.find_or_create_by!(name: tag_name)
end