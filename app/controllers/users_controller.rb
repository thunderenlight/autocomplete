class UsersController < ApplicationController
	before_filter :find_model

	def index
		respond_to do |format|
			if params[:term]
				@users = User.search_by_full_name(params[:term]).with_pg_search_highlight
			else
				@users = User.all
			end

			format.json
			format.html
		end
	end
	


	private
	def find_model
		@model = Model.find(params[:id]) if params[:id]
	end
end