module General
	def self.settings
		@settings ||= JSON.parse(File.read(::Rails.root.join('config','settings.json')), symbolize_names: true)
	end

	def self.twitter_token
		@twitter_token ||= Twitter::Api.get_token
	end
end
