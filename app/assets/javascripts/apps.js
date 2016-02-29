$(document).ready(function () {
    // $('#blueprint-panel').hide();
    // $(this).find('.toggle-blueprint-button-up-caret').hide();
    // $('.toggle-blueprint-button').click(function () {
    //   $(this).find('.toggle-blueprint-button-down-caret').toggle();
    //   $(this).find('.toggle-blueprint-button-up-caret').toggle();
    //   $(this).parent().parent().parent().find('#blueprint-panel').slideToggle();
    // });

    $("#write_review_button").click(function(){
      $(this).slideUp();
      $("#comment_form").slideDown();
    });

    update_pagination_link_class();

});

function update_pagination_link_class() {
   $.each( $('.pagination a'), function(i, obj) {
     $(obj).addClass('trigger-response-modal');
   });
};
