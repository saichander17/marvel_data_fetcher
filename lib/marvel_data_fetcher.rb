%w(rest-client).each { |dependency| require dependency }
module MarvelDataFetcher
	# https://developer.marvel.com/docs#%21/public/getCreatorCollection_get_0
	# Please check the above link to know what params can be passed
	def character_index(params)
		time_stamp = Time.zone.now.to_f
		payload = {
			# limit: params[:limit],
			# offset: params[:offset],
			apikey: marvel_public_key,
			ts: time_stamp,
			hash: md5("#{time_stamp}#{marvel_private_key}#{marvel_public_key}").hexdigest
		}
		params.each do |key, value|
			payload[key] = value
		end
		data = get_api_call(host+index_path, {params: payload})
		return data
	end

	def character_show(id)
		time_stamp = Time.zone.now.to_f
		payload = {
			apikey: marvel_public_key,
			ts: time_stamp,
			hash: md5("#{time_stamp}#{marvel_private_key}#{marvel_public_key}").hexdigest
		}
		data = get_api_call(host+show_path(id), {params: payload})
		data
	end

	private

		def md5(string)
			md5 = Digest::MD5.new
			md5.update string
			md5
		end

		def host
			"https://gateway.marvel.com:443"
		end

		def index_path
			"/v1/public/characters"
		end

		def show_path(id)
			"/v1/public/characters/#{id}"
		end

		def marvel_private_key
			Rails.application.secrets.marvel_private_key
		end

		def marvel_public_key
			Rails.application.secrets.marvel_public_key
		end

		def get_api_call(url, headers)
			begin
				data = RestClient::Request.execute(method: :get, url: url, headers: headers)
				data = {code: data.code, data: JSON.parse(data.body), headers: data.headers, cookies: data.cookies}
			rescue RestClient::Unauthorized, RestClient::Forbidden, RestClient::Conflict, RestClient::ResourceNotFound => err
	      data = JSON.parse(err.response)
	    rescue RestClient::InternalServerError => ex
	      data = {code: 500, error: "Server side exception\n" + formatted_exception_message(ex) }
	    rescue Exception => ex
	      data = {code: 503, error: formatted_exception_message(ex) }
	    end
	    data
		end

		def formatted_exception_message ex
	    return ex.backtrace.join("\n\t").sub("\n\t", ": #{ex}#{ex.class ? " (#{ex.class})" : ''}\n\t")
	  end
end