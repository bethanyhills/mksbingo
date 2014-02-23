 $(document).ready(function() {
  $("#submit").on('click',function(){
    var scoreboardRef = new Firebase('https://mksbingo.firebaseio.com/suggestion');
    if($("#suggestion").val() != "Have an idea for a Bingo tile?"){
      scoreBoard.addChild($("#suggestion").val());
    };
  });
};
