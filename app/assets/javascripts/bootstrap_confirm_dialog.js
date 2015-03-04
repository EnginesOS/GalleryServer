$.rails.allowAction = function(link) {
  if (!link.attr("data-confirm")) {
    return true;
  }
  $.rails.showConfirmDialog(link);
  return false;
};

// $.rails.confirmed = function(link) {
//   link.removeAttr("data-confirm");
//   return link.trigger("click.rails");
// };

$.rails.confirmed = function(link) {
  var linkclass;
  linkclass = link.attr('class');
  link.removeAttr('data-confirm');
  link.trigger('click.rails');
  if (link.attr('data-method') != 'delete') {
    return window.location.replace("" + link.context.href + "");
  }
};

$.rails.showConfirmDialog = function(link) {
  var html, body, title;
  title = link.attr("data-confirm-title");
  body = link.attr("data-confirm");

  if (title == undefined) { title = ' '; };

  html = '\
  <div class="modal fade" id="confirmation-dialog" tabindex="-1" role="dialog">\
    <div class="modal-dialog">\
      <div class="modal-content">\
        <div class="modal-header">\
          <button type="button" class="close" data-dismiss="modal">&times</button>\
          <h4 class="modal-title" id="myModalLabel">' + title + '</h4>\
        </div>\
        <div class="modal-body">\
          ' + body + '\
        </div>\
        <div class="modal-footer">\
          <button type="button" id="confirmation-dialog-cancel-button" class="btn btn-warning btn-lg" data-dismiss="modal">Cancel</button>\
          <button type="button" id="confirmation-dialog-accept-button" class="btn btn-danger btn-lg">OK</button>\
        </div>\
      </div>\
    </div>\
  </div>';

  $(html).modal();

  $(document).on('click', '#confirmation-dialog-accept-button', function() {
    $('#confirmation-dialog').modal('hide');
    $(document).on('hidden', '#confirmation-dialog', function () {
      $(this).remove();
    });
    $.rails.confirmed(link);
  });

  $(document).on('click', '#confirmation-dialog-cancel-button', function() {
    $('#confirmation-dialog').modal('hide');
    $('#confirmation-dialog').on('hidden.bs.modal', function () {
      $(this).remove();
    });
    $('#waiting-for-response-modal').modal('hide');
  });

};
