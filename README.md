This gem provides 2 public methods.
1) To fetch characters from marvel API. (https://gateway.marvel.com:443/v1/public/characters)
2) To fetch a character based on ID. (https://gateway.marvel.com:443/v1/public/characters/:id)

Usage: 
Please add the follwing keys in secrets
- marvel_private_key
- marvel_public_key

Then
include MarvelDataFetcher
in the file you want to use the method.
Then call character_index(params) to get the data of the first and character_show(id) to get the data of second API.
Please refer https://developer.marvel.com/docs#%21/public/getCreatorCollection_get_0 to know about the params for first API.