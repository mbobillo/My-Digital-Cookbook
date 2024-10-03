# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
RecipeTag.destroy_all
RecipeIngredient.destroy_all
Tag.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
Category.destroy_all

categories = Category.create([
  { id: 0, name: "Entrée" },
  { id: 1, name: "Plat" },
  { id: 2, name: "Sauce" },
  { id: 3, name: "Dessert" }
  ])

recipes = Recipe.create([
  { title: "Sauce Ranch", category: categories.find { |c| c.name == "Sauce" }, main_ingredient: "Mayonnaise" },
  { title: "Salade César", category: categories.find { |c| c.name == "Plat" }, main_ingredient: "Laitue" },
  { title: "Poulet au curry", category: categories.find { |c| c.name == "Plat" }, main_ingredient: "Poulet" },
  { title: "Julienne de crudités", category: categories.find { |c| c.name == "Entrée" }, main_ingredient: "Carotte" },
  { title: "Nems", category: categories.find { |c| c.name == "Entrée" }, main_ingredient: "Feuille de riz" },
  { title: "Sauce Cacouhète", category: categories.find { |c| c.name == "Sauce" }, main_ingredient: "Beurre de cacahouète" },
  { title: "Muffin au chocolat", category: categories.find { |c| c.name == "Dessert" }, main_ingredient: "Chocolat" },
  { title: "Tarte aux fraises", category: categories.find { |c| c.name == "Dessert" }, main_ingredient: "Fraise" }
])


ingredients = Ingredient.create([
  { name: "Mayonnaise" },
  { name: "Laitue" },
  { name: "Poulet" },
  { name: "Carotte" },
  { name: "Feuille de riz" },
  { name: "Piment" },
  { name: "Chocolat" },
  { name: "Fraise" },
  { name: "Huile d'olive" },
  { name: "Parmesan" },
  { name: "Ail" },
  { name: "Crouton" },
  { name: "Anchois" },
  { name: "Vinaigre de cidre" },
  { name: "Gimgembre" },
  { name: "Farine" },
  { name: "Beurre" },
  { name: "Sucre" },
  { name: "Oeuf" },
  { name: "Sauce de soja" },
  { name: "Oignon" },
  { name: "Navet" },
  { name: "Poivron" },
  { name: "Tabasco" },
  { name: "Vinaigre de riz" },
  { name: "Beurre de cacahouète" },
])

tags = Tag.create([
  { name: "Rapide" },
  { name: "Simple" },
  { name: "Gastro" },
  { name: "Adaptable" },
  { name: "Végé" },
  { name: "Protéine" },
  { name: "Eté" },
  { name: "Hiver" },
  { name: "Kids" },
  { name: "Solo" },
  { name: "Familial" },
  { name: "Cuisson plaques" },
  { name: "Cuisson four" },
  { name: "Sans cuisson" },
  { name: "A essayer" },
  { name: "Validé" },
  { name: "A anticiper" },
])

recipe_ingredients = RecipeIngredient.create([
  { recipe_id: recipes[0].id, ingredient_id: ingredients[5].id },
  { recipe_id: recipes[0].id, ingredient_id: ingredients[8].id },
  { recipe_id: recipes[0].id, ingredient_id: ingredients[10].id },
  { recipe_id: recipes[1].id, ingredient_id: ingredients[2].id },
  { recipe_id: recipes[1].id, ingredient_id: ingredients[10].id },
  { recipe_id: recipes[1].id, ingredient_id: ingredients[9].id },
  { recipe_id: recipes[1].id, ingredient_id: ingredients[11].id },
  { recipe_id: recipes[1].id, ingredient_id: ingredients[12].id },
  { recipe_id: recipes[2].id, ingredient_id: ingredients[3].id },
  { recipe_id: recipes[2].id, ingredient_id: ingredients[21].id },
  { recipe_id: recipes[2].id, ingredient_id: ingredients[22].id },
  { recipe_id: recipes[2].id, ingredient_id: ingredients[20].id },
  { recipe_id: recipes[3].id, ingredient_id: ingredients[8].id },
  { recipe_id: recipes[3].id, ingredient_id: ingredients[10].id },
  { recipe_id: recipes[3].id, ingredient_id: ingredients[20].id },
  { recipe_id: recipes[4].id, ingredient_id: ingredients[1].id },
  { recipe_id: recipes[4].id, ingredient_id: ingredients[2].id },
  { recipe_id: recipes[4].id, ingredient_id: ingredients[3].id },
  { recipe_id: recipes[5].id, ingredient_id: ingredients[8].id },
  { recipe_id: recipes[5].id, ingredient_id: ingredients[10].id },
  { recipe_id: recipes[5].id, ingredient_id: ingredients[13].id },
  { recipe_id: recipes[5].id, ingredient_id: ingredients[14].id },
  { recipe_id: recipes[5].id, ingredient_id: ingredients[19].id },
  { recipe_id: recipes[6].id, ingredient_id: ingredients[15].id },
  { recipe_id: recipes[6].id, ingredient_id: ingredients[16].id },
  { recipe_id: recipes[6].id, ingredient_id: ingredients[17].id },
  { recipe_id: recipes[6].id, ingredient_id: ingredients[18].id },
  { recipe_id: recipes[7].id, ingredient_id: ingredients[15].id },
  { recipe_id: recipes[7].id, ingredient_id: ingredients[16].id },
  { recipe_id: recipes[7].id, ingredient_id: ingredients[17].id },
  { recipe_id: recipes[7].id, ingredient_id: ingredients[18].id },
])

recipe_tags = RecipeTag.create([
  {recipe_id: recipes[0].id, tag_id: tags[0].id },
  {recipe_id: recipes[0].id, tag_id: tags[13].id },
  {recipe_id: recipes[0].id, tag_id: tags[15].id },
  {recipe_id: recipes[1].id, tag_id: tags[1].id },
  {recipe_id: recipes[1].id, tag_id: tags[3].id },
  {recipe_id: recipes[1].id, tag_id: tags[5].id },
  {recipe_id: recipes[1].id, tag_id: tags[13].id },
  {recipe_id: recipes[2].id, tag_id: tags[7].id },
  {recipe_id: recipes[2].id, tag_id: tags[5].id },
  {recipe_id: recipes[2].id, tag_id: tags[8].id },
  {recipe_id: recipes[3].id, tag_id: tags[1].id },
  {recipe_id: recipes[3].id, tag_id: tags[4].id },
  {recipe_id: recipes[3].id, tag_id: tags[6].id },
  {recipe_id: recipes[3].id, tag_id: tags[9].id },
  {recipe_id: recipes[3].id, tag_id: tags[2].id },
  {recipe_id: recipes[3].id, tag_id: tags[3].id },
  {recipe_id: recipes[3].id, tag_id: tags[8].id },
  {recipe_id: recipes[3].id, tag_id: tags[14].id },
  {recipe_id: recipes[3].id, tag_id: tags[13].id },
  {recipe_id: recipes[4].id, tag_id: tags[3].id },
  {recipe_id: recipes[4].id, tag_id: tags[8].id },
  {recipe_id: recipes[4].id, tag_id: tags[12].id },
  {recipe_id: recipes[4].id, tag_id: tags[13].id },
  {recipe_id: recipes[5].id, tag_id: tags[2].id },
  {recipe_id: recipes[5].id, tag_id: tags[8].id },
  {recipe_id: recipes[5].id, tag_id: tags[12].id },
  {recipe_id: recipes[5].id, tag_id: tags[6].id },
  {recipe_id: recipes[5].id, tag_id: tags[8].id },
  {recipe_id: recipes[6].id, tag_id: tags[2].id },
  {recipe_id: recipes[6].id, tag_id: tags[6].id },
  {recipe_id: recipes[6].id, tag_id: tags[12].id },
  {recipe_id: recipes[6].id, tag_id: tags[16].id },
  {recipe_id: recipes[6].id, tag_id: tags[7].id },
  {recipe_id: recipes[7].id, tag_id: tags[12].id },
  {recipe_id: recipes[7].id, tag_id: tags[3].id },
])
