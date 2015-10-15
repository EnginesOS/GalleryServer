$(document).ready(function(){



$('input[type="submit"]').click( function(e) {

    e.preventDefault();
    alert("Can't submit until the error message is gone");

});


  $(".devise-view").each( function() {

    if ( $(this).find(".do-not-apply-devise-view-js-formatting").length == 0 ) {

      $(this).addClass("col-sm-6 col-sm-offset-3");
      $(".devise-view input[name='commit']").each( function(){
          $(this).addClass("btn btn-primary btn-lg top-gap");
      });
      $(".devise-view label").each( function(){
          $(this).addClass("top-gap");
      });
      $(".devise-view .field input[type!='checkbox']").each( function(){
          $(this).addClass("form-control input-lg");
      });

      $(".devise-view a").each( function(){
          $(this).addClass("btn btn-default trigger-response-modal");
      });

    };

  });

});

