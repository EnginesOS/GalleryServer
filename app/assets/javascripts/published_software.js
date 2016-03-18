$(document).ready(function () {

    $("#write_review_button").click(function(){
      $(this).slideUp();
      $("#comment_form").show();
    });
    update_pagination_link_class();
    $( "#published_software_blueprint_modal" ).on('shown.bs.modal', function(){
      load_blueprint_to_modal();
    });
});

function load_blueprint_to_modal() {
  $.ajax({
      url: $('#blueprint_load_data').attr('data-url'),
      cache: false,
      success: function(html){
        $("#blueprint_load_data").parent().html(html);
      }
  });
};

function update_pagination_link_class() {
   $.each( $('.pagination a'), function(i, obj) {
     $(obj).addClass('trigger-response-modal');
   });
};
