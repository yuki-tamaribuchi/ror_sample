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
end
