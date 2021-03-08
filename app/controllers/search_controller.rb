class SearchController < ApplicationController

  def search
  	# @guests = Guest.all
    # ページング機能実装のため、上記を下記に変更
    # @guests = Guest.page(params[:page]).reverse_order
    # 12,14行目から情報を引き出し、引き出す記述にページネーションの記述を足したため上記の記述は不要
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