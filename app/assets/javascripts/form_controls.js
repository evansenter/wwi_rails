var lockout_form = function(button_id) {
  $("form :input.required").change(function(element) {
    var filled_out = _.all($("form .required"), function(el) { return $(el).val() != "" });

    if (filled_out) {
      $(button_id).removeAttr("disabled");
    } else {
      $(button_id).attr("disabled", "disabled");
    }
  });
}
