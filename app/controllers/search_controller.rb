class SearchController < ApplicationController

  def search

		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'number'
			 @records = Guest.number_search_for(@content, @method)
		elsif @model == 'name'
					@records = Guest.name_search_for(@content, @method)
		end

  end

end