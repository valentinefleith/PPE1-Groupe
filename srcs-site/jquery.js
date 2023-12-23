$(document).ready(function(){
    
    //Title fades in//
    $(".titleText").hide();
    $(".wordContainer").hide();
    $(".authorContainer").hide();
    
    $(document).hover(function(){
        $(".titleText").fadeIn("slow");
        $(".wordContainer").fadeIn("slow");
        $(".authorContainer").fadeIn(2000);
    });

});