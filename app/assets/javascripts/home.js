$(document).ready(function(){

    if (document.getElementsByClassName("home_page").length) {

      $('#home-page-video-modal').on('shown.bs.modal', function() {
        $('#home-page-video-modal video')[0].play();
      });

      $('#home-page-video-modal').on('hidden.bs.modal', function() {
        $('#home-page-video-modal video')[0].pause();
      });

      $('#open_social_links_button').click( function() {
        $(this).html('<i class="fa fa-spinner fa-spin loading_spinner"></i>');
        $.ajax({
          url : "/home_social_buttons",
          cache : true,
          timeout: 5000,
          success : function(html) {
            $('#open_social_links_button').after(html);
            setTimeout(function(){
              $('#open_social_links_button').hide();
              $('#social_share_buttons_holder').removeClass("hide_while_loading");
            }, 2000);
          },
          error: function(response, status, error){
            var html = '<i class="fa fa-warning"></i>'
            $('#open_social_links_button').html(html);
          }
        });
      });

    };
});
