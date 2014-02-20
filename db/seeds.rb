# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(title: 'Active Verbs', description: 'Active verbs description goes here')
Category.create(title: 'Participles', description: 'Participles description goes here')
Category.create(title: 'Absolutes', description: 'Absolutes description goes here')
Category.create(title: 'Appositives', description: 'Appositives description goes here')
Category.create(title: 'Adjectives Out of Order', description: 'Adjectives out of order description goes here')

Question.create(image_url: 'http://i.imgur.com/8ooDsfF.png', category_id: 1, good_example: 'Good example goes here', bad_example: 'Bad example goes here')
Question.create(image_url: 'http://i.imgur.com/138UxHv.png', category_id: 2, good_example: 'Good example goes here', bad_example: 'Bad example goes here')
Question.create(image_url: 'http://i.imgur.com/7vr3d7L.jpg', category_id: 2, good_example: 'Dog', bad_example: 'Dog')
