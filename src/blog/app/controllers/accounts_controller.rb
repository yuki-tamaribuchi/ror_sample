class AccountsController < ApplicationController
	def signup
		if request.get? then
			@user = User.new()
			render "signup"
		elsif request.post? then
			@user = User.new(user_params_with_confirmation)
			if @user.valid? then
				@user.save
				set_current_user_to_cookie(@user)
				redirect_to controller: "accounts", action: "detail", username: @user.username
			end
		end
	end

	def login
		if request.get? then
			@user = User.new()
			render "login"
		elsif request.post? then
			@user = User.find_by(username: params[:username])
			if @user == nil then
				login_error
			end

			if @user.authenticate(params[:password]) then
				set_current_user_to_cookie(@user)
			else
				login_error
			end

			redirect_to controller: "accounts", action: "detail", username: @user.username
		end
	end


	def logout
		unset_current_user_from_cookie
		redirect_to controller: "accounts", action: "login"
	end

	
	def detail
		@user = User.find_by(username: params[:username])
		if @user == nil then
			return render_not_found
		end

		render "detail"
	end

	
	def update
		@user = get_current_user
		
		if @user == nil then
		end

		if request.get? then
			render "update"
		elsif request.post? then
			@user.biograph = params[:biograph]
			@user.save()
			redirect_to controller: "accounts", action: "detail", username: @user.username
		end
			
	end

	def delete
		@user = get_current_user
		if request.get? then
			render "delete"
		elsif request.post? then
			@user.delete
			unset_current_user_from_cookie
			redirect_to controller: "accounts", action: "signup"
		end
	end

	private
	def user_params_with_confirmation
		params.permit(:username, :password, :password_confirmation)
	end

	def login_error
		@user = User.new()
		@message = "ユーザネームかパスワードが間違っています。"
		render "login"
	end

	def get_current_user
		User.find_by(id: cookies.signed['user_id'])
	end

	def set_current_user_to_cookie(user)
		cookies.signed[:user_id] = user.id
		cookies.signed[:username] = user.username
	end

	def unset_current_user_from_cookie
		cookies.delete :user_id
		cookies.delete :username
	end
end
