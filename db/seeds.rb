# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(email: 'admin@engines.onl', username: 'admin0', password: 'EngOS2014', password_confirmation: 'EngOS2014')
User.create(email: 'lachdoug@gmail.com', username: 'lachdoug', password: 'EngOS2014', password_confirmation: 'EngOS2014')
PublishedSoftware.create(title: 'Publify', detail: 'Great blogging software!!!!!!!!!!!', repository_url: 'https://github.com/EnginesOS-Blueprints/Publify.git')