require 'rubygems'
require 'unirest'



class UserInfo
    def self.gravatar_url(access_token)
    	response = Unirest.get('https://api.github.com/user/#{access_token}', {:params => {:access_token => access_token}})
    	gravatar = response.body["gravatar_id"]
    	"https://secure.gravatar.com/avatar/" + gravatar
    end

    def self.user_name(access_token)
    	response = Unirest.get('https://api.github.com/user/#{access_token}', {:params => {:access_token => access_token}})
    	username = response.body['login']
    end
end