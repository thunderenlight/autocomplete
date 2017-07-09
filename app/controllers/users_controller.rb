class UsersController < ApplicationController
	before_filter :find_model

	def index
		@users = User.all
		
	end
	

	private
	def find_model
		@model = Model.find(params[:id]) if params[:id]
	end
end