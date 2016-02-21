require 'net/http'
require 'net/https'
require 'uri'

module Twitter
	module Api
		@config = General.settings[:twitter]

		def self.get_token
			# Generate URI
			uri = URI.parse("https://#{@config[:host]}/oauth2/token")

			# Configure HTTP Connection
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE

			# Configure Request
			request = Net::HTTP::Post.new(uri.request_uri)
			request.set_form_data({ 'grant_type': 'client_credentials' })
			enc_bearer = Base64.strict_encode64("#{@config[:app_key]}:#{@config[:secret]}")
			request["Authorization"] = "Basic #{enc_bearer}"

			# Execute
			response = JSON.parse(http.request(request).body, symbolize_names: true)

			# Return Access Token
			"#{response[:token_type].capitalize} #{response[:access_token]}"
		end

		def self.user_timeline(screen_name)
			response = Rails.cache.fetch("twitter/#{screen_name}", expires_in: General.settings[:cache].to_i.minutes) do
				# Generate URI
				uri = URI.parse("https://#{@config[:host]}/#{@config[:version]}/statuses/user_timeline.json")
				uri.query = URI.encode_www_form({
					screen_name: screen_name,
					count: @config[:max_count]
				})

				# Configure HTTP Connection
				http = Net::HTTP.new(uri.host, uri.port)
				http.use_ssl = true
				http.verify_mode = OpenSSL::SSL::VERIFY_NONE

				# Configure Request
				request = Net::HTTP::Get.new(uri.request_uri)
				request["Authorization"] = General.twitter_token

				# Execute
				http.request(request)
			end

			# Response
			JSON.parse(response.body, symbolize_names: true)
		end
	end
end
