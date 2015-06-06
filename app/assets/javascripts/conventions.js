var open_new_convention = function(event) {
  event.preventDefault();
  $('#newConModal').foundation('reveal', 'open');
}

$('.new-item').click(open_new_convention);
