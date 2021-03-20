class SearchController < ApplicationController

  def search
		@content = params[:content]
		@model = params[:model]
		@method = params[:method]
		# 検索機能に並び替え機能追加
		@sort = params[:keyword]

		# 検索結果に対してページング機能記述を追記
		if @content.blank?
			@records = Guest.all
			@records = Guest.sort_by_params(@records, @sort).page(params[:page])
			# 空文字の場合は全ての投稿に対して並び替え機能のみを実装（上記３行）
		elsif @model == 'number'
			@records = Guest.number_search_for(@content, @method, @sort).page(params[:page])
		elsif @model == 'name'
			@records = Guest.name_search_for(@content, @method, @sort).page(params[:page])
		end
    
    # Postのページング・非同期実装のため、下記４行を追記
		respond_to do |format|
      format.html
      format.js
    end
  end

end