require "json"

class CategoryController < ApplicationController
	skip_forgery_protection

	def create
		content = JSON.parse(request.body.read)
		if !content.key?("name") || content["name"] == "" then
			data = { message: 'Please specify name as {"name":"YOUR_CATEGORY_NAME"}.'}
			return render json: data, status: 400
		end

		name = content["name"]

		category_in_db = Category.find_by(name: name)
		if category_in_db != nil then
			data = { message: '%s is already exists.' % name}
			return render json: data, status: 409
		end

		category = Category.create(
			name: name
		)
		data = {message: 'Category %s was created.' % name, name: category.name }
		render json: data, status: 201
	end
end
