$(document).ready(function () {
    $('.hide-detail-button').hide();
    $('.blueprint-details-dropdown-body').hide();
    $('.show-detail-button').click(function () {
      $(this).parent().find('.show-detail-button').hide();
      $(this).parent().find('.hide-detail-button').show();
      $(this).parent().find('.blueprint-details-dropdown-body').show();
    });
    $('.hide-detail-button').click(function () {
      $(this).parent().find('.hide-detail-button').hide();
      $(this).parent().find('.show-detail-button').show();
      $(this).parent().find('.blueprint-details-dropdown-body').hide();
    });
});