$(document).ready(function(){

    if (document.getElementsByClassName("home_page").length) {
      $("html").addClass("home_page_background_cover");

      $.get("tags/tag_cloud", function(data){
            $("#tag_cloud_holder").html(data);
            bind_trigger_response_modal_events();
          });



$('#home-page-video-modal').on('shown.bs.modal', function() {
  $('#home-page-video-modal video')[0].play();
});

$('#home-page-video-modal').on('hidden.bs.modal', function() {
  $('#home-page-video-modal video')[0].pause();
});




    };

});
