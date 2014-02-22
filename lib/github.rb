require 'rubygems'
require 'unirest'
require 'pry'

class UserInfo
    def self.gravatar_url(username)
    	response = Unirest.get('https://api.github.com/user', {:params => {:access_token => access_token}})
    	gravatar = response.body["gravatar_id"]
    	"https://secure.gravatar.com/avatar/" + gravatar