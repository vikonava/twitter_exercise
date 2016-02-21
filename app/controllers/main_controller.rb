class MainController < ApplicationController
  def index
  end

	def timeline
		if user_signed_in?
			@timeline = Twitter::Api.user_timeline(params[:screen_name])

			@timeline.each do |status|
				status[:text].scan(/(?<=^@|\s@)\w+(?=$|\s)/).uniq.compact.each do |mention|
					status[:text].gsub!("@#{mention}", "<a href='https://twitter.com/#{mention}'>@#{mention}</a>")
				end
			end

			render layout: false
		else
			render status: 403
		end
	end
end
