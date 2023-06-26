# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user1 = User.create(name: 'Jaime', email: 'jaimevillegas296@gmail.com', password: 'test123')
user2 = User.create(name: 'Dico', email: 'dicodiaz@gmail.com', password: 'test123')

food1 = Food.create(name: 'Borojo', measurement_unit: 'Units', price: 5.0, quantity: 2, user: user1)
food2 = Food.create(name: 'Platano', measurement_unit: 'Units', price: 3.0, quantity: 3, user: user2)

recipe1 = Recipe.create(name: 'Jugo de borojo', preparation_time: '20 minutes', cooking_time: '5 minutes',
                        description: 'Agregue agua y fruta y ponga a licuar', public: true, user_id: user1.id)
recipe2 = Recipe.create(name: 'Sancocho', preparation_time: '30 minutes', cooking_time: '2 hours',
                        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tincidunt accumsan risus, eget iaculis tortor vestibulum sed. Suspendisse tincidunt, tortor eget pharetra vulputate, sem ex faucibus lorem, vel sodales ligula felis in enim. Quisque dapibus fermentum ornare. Phasellus congue molestie tempor. Pellentesque dapibus tortor at ante molestie gravida. Nullam at gravida lectus. Fusce neque dolor, maximus quis sodales in, interdum in felis. Praesent ut ipsum ac mauris lobortis ornare in nec lectus. Curabitur tincidunt ornare leo finibus tincidunt. Suspendisse potenti.', public: false, user_id: user2.id)

recipe_food1 = RecipeFood.create(quantity: 1, recipe_id: recipe1.id, food_id: food1.id)
recipe_food2 = RecipeFood.create(quantity: 2, recipe_id: recipe2.id, food_id: food2.id)
