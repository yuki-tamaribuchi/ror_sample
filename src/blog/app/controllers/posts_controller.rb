class PostsController < ApplicationController
	def index
	end


	def new
		@post = Post.new()
	end

	
	def create
		user_id = cookies.signed[:user_id]
		post = Post.new(
			title: params[:post][:title],
			content: params[:post][:content]
		)
		post.user_id = user_id
		if post.valid? then
			post.save()
		end
	end

	def show
		@post = Post.includes(:user).find(params[:id])
	end
end
