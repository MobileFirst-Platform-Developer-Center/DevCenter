// Features page navigation
$(".feature-analytics").css("display", "block");
$(".analytics").css("background","#c3e5f8");

$(".feature-analytics-img").on("click", function() {
    // Display the corresponding div element
    $(".feature-analytics").css("display","block");
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-management").css("display","none");
    
    // Change background color for active feature
    $(".analytics").css("background","#c3e5f8");
    $(".push").css("background","none");
    $(".security").css("background","none");
    $(".backend-logic").css("background","none");
    $(".management").css("background","none");
});

$(".feature-push-img").on("click", function() {
    $(".feature-analytics").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-push").css("display","block");
    $(".feature-management").css("display","none");
    
    $(".analytics").css("background","none");
    $(".push").css("background","#c3e5f8");
    $(".security").css("background","none");
    $(".backend-logic").css("background","none");
    $(".management").css("background","none");
});

$(".feature-security-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-management").css("display","none");
    $(".feature-security").css("display","block");
    
    $(".analytics").css("background","none");
    $(".push").css("background","none");
    $(".security").css("background","#c3e5f8");
    $(".backend-logic").css("background","none");
    $(".management").css("background","none");
});

$(".feature-backend-logic-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-backend-logic").css("display","block");
    $(".feature-management").css("display","none");
    
    $(".analytics").css("background","none");
    $(".push").css("background","none");
    $(".security").css("background","none");
    $(".backend-logic").css("background","#c3e5f8");
    $(".management").css("background","none");
});

$(".feature-management-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-management").css("display","block");
    
    $(".analytics").css("background","none");
    $(".push").css("background","none");
    $(".security").css("background","none");
    $(".backend-logic").css("background","none");
    $(".management").css("background","#c3e5f8");
});