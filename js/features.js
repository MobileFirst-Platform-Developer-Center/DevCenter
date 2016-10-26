// Features page navigation
$(".feature-analytics").css("display", "block");

$(".feature-analytics-img").on("click", function() {
    $(".feature-analytics").css("display","block");
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-management").css("display","none");
});

$(".feature-push-img").on("click", function() {
    $(".feature-analytics").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-push").css("display","block");
    $(".feature-management").css("display","none");
});

$(".feature-security-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-management").css("display","none");
    $(".feature-security").css("display","block");
});

$(".feature-backend-logic-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-backend-logic").css("display","block");
    $(".feature-management").css("display","none");
});

$(".feature-management-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-management").css("display","block");
});