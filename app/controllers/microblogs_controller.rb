class MicroblogsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user,   only: :destroy

	def index
	end

	def create
		@microblog = current_user.microblogs.build(params[:microblog])
		if @microblog.save
			flash[:success] = "Micoblog created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@microblog.destroy
		redirect_to root_url
	end

	private

		def correct_user
			@microblog = current_user.microblogs.find_by_id(params[:id])
			redirect_to root_url if @microblog.nil?
		end
end