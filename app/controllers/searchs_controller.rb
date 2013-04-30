class SearchsController < ApplicationController

	def showResult
		@users = User.find_by_name(params[:searchs][:name])
		
	end
end
