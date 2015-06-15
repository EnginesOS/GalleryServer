$(document).ready(function(){

    $(".devise-view").each( function() {

if ( $(this).find(".do-not-apply-devise-view-js-formatting").length == 0 ) {

      $(this).addClass("col-sm-6 col-sm-offset-3");
      $(".devise-view input[name!='commit'][type!='checkbox']").each( function(){
          $(this).addClass("form-control");
      });
      $(".devise-view input[name='commit']").each( function(){
          $(this).addClass("btn btn-primary btn-lg top-gap trigger-response-modal");
      });
      $(".devise-view label").each( function(){
          $(this).parent().addClass("top-gap");
      });
      $(".devise-view a").each( function(){
          $(this).addClass("btn btn-default btn-sm top-gap trigger-response-modal");
      });
};

    });
});

