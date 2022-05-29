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

	def edit
		@post = Post.find(params[:id])
	end


	def update
		post = Post.find(params[:id])

		if post.user_id != cookies.signed[:user_id] then
			return render_forbidden
		end

		post.title = params[:post][:title]
		post.content = params[:post][:content]

		if post.valid? then
			post.save()
			redirect_to controller: "posts", action: "show", id: post.id
		end
	end


	def destroy_confirm
		@post = Post.find(params[:id])

		if @post.user_id != cookies.signed[:user_id]
			return render_forbidden
		end
	end


	def destroy
		post = Post.find(params[:id])
		if post.user_id != cookies.signed[:user_id]
			return render_forbidden
		end

		post.delete()
		redirect_to controller: "accounts", action: "detail", username: cookies.signed[:username]
	end

	private
	def category_params
		params.require(:post).permit(categories: [])
	end
end
