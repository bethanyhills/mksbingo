 $(document).ready(function() {
  $("#submit").on('click',function(){
    var suggestionRef = new Firebase('https://mksbingo.firebaseio.com/suggestion');
    if($("#suggestion").val() != "Have an idea for a Bingo tile?"){
      suggestionRef.push($("#suggestion").val());
      $("#suggestion").attr("placeholder", "Thank you!");
      $("#suggestion").val("");
    };
  });
});
