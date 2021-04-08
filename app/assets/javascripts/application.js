// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require moment
//= require fullcalendar
//= require jquery.raty.js

// リンクタグでページ移動した際に正しく読み込みがされるように「$(document).on('turbolinks:load',」を追加
$(document).on('turbolinks:load',function() {
    var pagetop = $('#page_top');
    pagetop.hide();
    // console.log("page_topは無効化されています")
    // 100pxスクロールしたら表示
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            pagetop.fadeIn();
            console.log("フェードイン")
        } else {
            console.log("フェードアウト")
            pagetop.fadeOut();
        }
    });
    // 0.5秒かけてページトップへ移動
    pagetop.click(function () {
        $('body,html').animate({
            scrollTop: 0
        }, 500);
        return false;
    });
});