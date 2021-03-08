class SearchController < ApplicationController

  def search
  	# @guests = Guest.all
    # ページング機能実装のため、上記を下記に変更
    # @guests = Guest.page(params[:page]).reverse_order
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'number'
			 @records = Guest.number_search_for(@content, @method).page(params[:page]).reverse_order
		elsif @model == 'name'
					@records = Guest.name_search_for(@content, @method).page(params[:page]).reverse_order
		end

  end

end