class Adapter
  URL = "https://pokeapi.co/"

  def get_pokemon_by_number(number)
    JSON.parse(RestClient.get(URL+"api/v1/pokemon/#{number}/"))
  end

  def get_random_pokemon
    number = rand(1..151)
    JSON.parse(RestClient.get(URL+"api/v1/pokemon/#{number}/"))
  end
end
