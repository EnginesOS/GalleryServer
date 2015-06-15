jQuery(document).ready(function($) {
  $(".clickable-table-row td").not(".association_table_actions").click(function() {
    window.document.location = $(this).parent().attr("href");
  });
  $(".clickable-table-row td").not(".association_table_actions").css('cursor', 'pointer');
  $(".clickable-table-row td").not(".association_table_actions").addClass('trigger-response-modal');
});