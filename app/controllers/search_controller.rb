class SearchController < ApplicationController

  def search
		@content = params[:content]
		@model = params[:model]
		@method = params[:method]

		if
		  # 入力が空文字の場合
		  @records = Guest.all
		elsif
		  @model == 'number'
			@records = Guest.number_search_for(@content, @method)
		elsif
			@model == 'name'
			@records = Guest.name_search_for(@content, @method)
		end

    # 並び替え実装
    @records = @records.sort_by_params(params[:keyword])

    #ページング機能実装のため、1=>2=>3=>から下記に変更
    #1.@guests = Guest.all
    #2.@guests = Guest.page(params[:page]).reverse_order
    #3.@records = Guest.number_search_for(@content, @method).page(params[:page]).reverse_order
		@records = @records.page(params[:page])

    # Postのページング・非同期実装のため、下記４行を追記
		respond_to do |format|
      format.html
      format.js
    end
  end

end