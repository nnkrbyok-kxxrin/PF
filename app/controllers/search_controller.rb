class SearchController < ApplicationController

  def search
		@content = params[:content]
		@model = params[:model]
		@method = params[:method]
		# 検索機能に並び替え機能追加
		@sort = params[:keyword]
		# 検索機能にタグ検索追加
		@tag_list = params[:tag_list]

		# ログインしている人に基づくもののみを表示
		@records = current_admin.guests.all
		# contentに入力がある？ => あればcontent_search_forへ
		@records = Guest.content_search_for(@records, @content, @model, @method) if params[:content].present?
		# tag_listに入力がある？ => あればtag_search_forへ
		@records = @records.tag_search_for(@records, params[:tag_list].split(',')) if params[:tag_list].present?
		# 全ての検索結果に対して並び替え機能実装+ページング機能記述を追記
		@records = Guest.sort_by_params(@records, @sort).page(params[:page])

    # Postのページング・非同期実装のため、下記４行を追記
		respond_to do |format|
      format.html
      format.js
    end
  end

end