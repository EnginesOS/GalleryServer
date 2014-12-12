$(document).ready(function(){

    // if (document.getElementById('form-buttons')) {
        bind_button_events();
    // };
});

function bind_button_events() {

        $(".trigger-response-modal").click(function(){
          show_modal();
        });

        function show_modal() {
          $('#waiting-for-response-modal').modal('show');
        };

};
