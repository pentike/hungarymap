/**
 * Kiválasztja a megye listából azt a megyét, amire a térképen kattintottak.
 */
$(document).ready(function() {
    $('#mapHu').maphilight();
    $('area').click(function(e) {
      var megye=$(this).attr('title');
      $('#edit-megye option').each(function() {
          if($(this).text() == megye) {
            $(this).attr("selected","selected");
          }
        });
      });
});
