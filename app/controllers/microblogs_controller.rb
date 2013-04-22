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

	def expand
		@replied = Microblog.including_replies(params[:id])
		@micropost_id = params[:id]
		#@replied=[]
		#@replied.push(Microblog.find(2))
		#@replied.push(Microblog.find(3))
	  respond_to do |format| 
      format.html { redirect_to root_path }
      format.js 
    end

	end

	def view_conversation
		@reply_microblog = []
		@micropost_id = params[:id]
		@reply_microblog = has_reply_microblog(params[:id])
		#@reply_microblog.push(Microblog.find(2))
		respond_to do |format| 
      format.html { redirect_to root_path }
      format.js 
    end
	end

	private

		def has_reply_microblog(microblog_id)
			reply_microblog_item = []
			microblog_id = Microblog.find(microblog_id).in_reply_to
			while (!microblog_id.nil?)
				reply_microblog_item.push(Microblog.find(microblog_id))
				microblog_id = Microblog.find(microblog_id).in_reply_to
			end
			reply_microblog_item.reverse
		end

		def correct_user
			@microblog = current_user.microblogs.find_by_id(params[:id])
			redirect_to root_url if @microblog.nil?
		end
end