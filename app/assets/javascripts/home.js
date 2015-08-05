$(document).ready(function(){

    if (document.getElementsByClassName("home_page").length) {
      $("html").addClass("home_page_background_cover");

      $.get("tags/tag_cloud", function(data){
            $("#tag_cloud_holder").html(data);
            bind_trigger_response_modal_events();
          });

    };

});
