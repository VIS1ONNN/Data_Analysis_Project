# Basic Request API

## create function to get infomation from api request by name
## import library
from requests import get
from time import sleep
import csv

## checking url status
base_url = "https://pokeapi.co/api/v2/"
response = get(base_url)

## create function
def get_pokemon_info(name):
    url = f"{base_url}pokemon/{name}"
    response = get(url)
    if response.status_code == 200 :
        pokemon_data = response.json()
        return(pokemon_data)
    else :
        print(f"Failed to retrived data {response.status_code}")

## get "pikachu" info
pokemon_name = "pikachu" 
pokemon_info = get_pokemon_info(pokemon_name)

## checking key from pokemon_info dictionary

"""
for key in pokemon_info:
    print(key)

abilities
base_experience
cries
forms
game_indices
height
held_items
id
is_default
location_area_encounters
moves
name
order
past_abilities
past_types
species
sprites
stats
types
weight
"""

## print result
if pokemon_info:
    print(f"Name : {pokemon_info['name'].capitalize()}")
    print(f"Id : {pokemon_info['id']}")
    print(f"Weight : {pokemon_info['weight']}")
    print(f"Height : {pokemon_info['height']}")
    print(f"Base experience : {pokemon_info['base_experience']}")
"""
Name : Pikachu
Id : 25
Weight : 60
Height : 4
Base experience : 112
"""


# create loop to get data and write down to csv.file
## url checking
base_url = "https://pokeapi.co/api/v2/pokemon/"
response = get(base_url)

## status response check
response.status_code

## check key from response dictionary
# for key in response.json():
    # print(key)

## create empty list
pokemon_list = []

## request data range 1-10
for i in range(1,11):
    url = f"https://pokeapi.co/api/v2/pokemon/{i}"
    response = get(url)
    response_js = response.json()
    name = response_js['name']
    id = response_js['id']
    weight = response_js['weight']
    height = response_js['height']
    base_exp = response_js['base_experience']
    result = [name, id, weight, height, base_exp]
    pokemon_list.append(result)
    sleep(3)

# print(pokemon_list)

header = ['name', 'id', 'weight', 'height', 'base_exp']

with open('pokemon_list.csv', 'w') as file:
    writer = csv.writer(file)
    writer.writerow(header)
    writer.writerows(pokemon_list)

!cat pokemon_list.csv

"""
name,id,weight,height,base_exp
bulbasaur,1,69,7,64
ivysaur,2,130,10,142
venusaur,3,1000,20,263
charmander,4,85,6,62
charmeleon,5,190,11,142
charizard,6,905,17,267
squirtle,7,90,5,63
wartortle,8,225,10,142
blastoise,9,855,16,265
caterpie,10,29,3,39
"""
