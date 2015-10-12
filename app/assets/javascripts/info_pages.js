$(document).ready(function(){

    if ($("#pages_sub_nav").length) {

      function resize_sub_nav_toolbar() {
        if ($(window).width() >= 977) {
            $("#pages_sub_nav").addClass("btn-group");
            $("#pages_sub_nav").removeClass("btn-group-vertical").removeClass("pull-right");
        } else {
            $("#pages_sub_nav").removeClass("btn-group");
            $("#pages_sub_nav").addClass("btn-group-vertical").addClass("pull-right");
        };
      };

      $( window ).resize(function() {
        resize_sub_nav_toolbar();
      });

      resize_sub_nav_toolbar();

    };


    if ($("#screenshots_carousel").length) {

      $("#screenshots_carousel").click(function() {
        $("#screenshots_carousel").carousel('next');
      });

    };

});
