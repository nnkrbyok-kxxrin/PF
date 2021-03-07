class SearchController < ApplicationController

  def search
  	# @guests = Guest.all
    # ページング機能実装のため、上記を下記に変更
    @guests = Guest.page(params[:page]).per(10)

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