$(document).ready(function () {
    $('.blueprint-details-dropdown-body').hide();
    $(this).find('.toggle-blueprint-button-up-caret').hide();
    $('.toggle-blueprint-button').click(function () {
      $(this).find('.toggle-blueprint-button-down-caret').toggle();
      $(this).find('.toggle-blueprint-button-up-caret').toggle();
      $(this).parent().parent().parent().find('.blueprint-details-dropdown-body').slideToggle();
    });

});