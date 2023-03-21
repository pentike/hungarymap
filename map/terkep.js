/**
 * Kiválasztja a vármegye listából azt a megyét, amire a térképen kattintottak.
 */
$(document).ready(function() {
    $('#mapHu').maphilight();
    $('area').click(function(e) {
      var varmegye=$(this).attr('title');
      $('#edit-varmegye option').each(function() {
          if($(this).text() == varmegye) {
            $(this).attr("selected","selected");
          }
        });
      });
});
