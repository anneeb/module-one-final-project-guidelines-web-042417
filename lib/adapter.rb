require "json"

class Adapter
  URL = "https://pokeapi.co/"

  def self.get_pokemon_by_number(number)
    JSON.parse(RestClient.get(URL+"api/v1/pokemon/#{number}/"))
  end

  def self.get_random_pokemon
    number = rand(1..151)
    JSON.parse(RestClient.get(URL+"api/v1/pokemon/#{number}/"))
  end
end
