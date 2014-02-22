$(document).ready(function() {
  var gameSelections = [];
  for(i=0;i<25;i++){
    gameSelections.push(false);
    if(i==12){
    gameSelections[i] = true;
    $()
    }
  }

  var dataRef = new Firebase('https://mksbingo.firebaseio.com/board');
  var dataRefSel = new Firebase('https://mksbingo.firebaseio.com/selected');
  var board_array = []
  var selected_array = []
  for(var i = 0; i < 25; i++){
    board_array[i] = $("#cell"+i).text().replace("\n    \n    ","");
    if($("#cell"+i).hasClass('selected')){
      selected_array[i] = true
    } else {
      selected_array[i] = false
    }
  }
  dataRef.set(board_array)
  dataRefSel.set(selected_array)


  $(".square").on("click", function(){
    $(this).addClass("selected");
    var cellID = Number($(this).attr('id').replace("cell", ""));
    gameSelections[cellID]=true;
    var dataRef = new Firebase('https://mksbingo.firebaseio.com/selected/'+cellID);
    dataRef.set(true);
    checkGameWin();
  })

  var checkGameWin = function() {
      // horizontal win
    if(gameSelections[0]&&gameSelections[1]&&gameSelections[2]&&gameSelections[3]&&gameSelections[4] ||
      gameSelections[5]&&gameSelections[6]&&gameSelections[7]&&gameSelections[8]&&gameSelections[9] ||
      gameSelections[10]&&gameSelections[11]&&gameSelections[12]&&gameSelections[13]&&gameSelections[14] ||
      gameSelections[15]&&gameSelections[16]&&gameSelections[17]&&gameSelections[18]&&gameSelections[19] ||
      gameSelections[20]&&gameSelections[21]&&gameSelections[22]&&gameSelections[23]&&gameSelections[24] ||
      // vertical win
      gameSelections[0]&&gameSelections[5]&&gameSelections[10]&&gameSelections[15]&&gameSelections[20] ||
      gameSelections[1]&&gameSelections[6]&&gameSelections[11]&&gameSelections[16]&&gameSelections[21] ||
      gameSelections[2]&&gameSelections[7]&&gameSelections[12]&&gameSelections[17]&&gameSelections[22] ||
      gameSelections[3]&&gameSelections[8]&&gameSelections[13]&&gameSelections[18]&&gameSelections[23] ||
      gameSelections[4]&&gameSelections[9]&&gameSelections[14]&&gameSelections[19]&&gameSelections[24] ||
      // diagonal wins
      gameSelections[0]&&gameSelections[6]&&gameSelections[12]&&gameSelections[18]&&gameSelections[24] ||
      gameSelections[4]&&gameSelections[8]&&gameSelections[12]&&gameSelections[16]&&gameSelections[20]) {
       alert("You won!")
     }
  }
});
