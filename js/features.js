// Features page navigation

// Default display on page load
$(".feature-security").css("display", "block");
$(".security").css("background","#c3e5f8");

// Display different feature lists
$(".feature-security-img").on("click", function() {
    resetList();
    $(".feature-security").css("display","block");
    $(".security").css("background","#c3e5f8");
});

$(".feature-management-img").on("click", function() {
    resetList();
    $(".feature-management").css("display","block");
    $(".management").css("background","#c3e5f8");
});

$(".feature-analytics-img").on("click", function() {
    resetList();
    $(".feature-analytics").css("display", "block");
    $(".analytics").css("background","#c3e5f8");
});

$(".feature-backend-logic-img").on("click", function() {
    resetList();
    $(".feature-backend-logic").css("display","block");
    $(".backend-logic").css("background","#c3e5f8");
});

$(".feature-push-img").on("click", function() {
    resetList();
    $(".feature-push").css("display","block");
    $(".push").css("background","#c3e5f8");
});

// Reset function
function resetList() {
    $(".feature-security").css("display","none");
    $(".feature-management").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-push").css("display","none");

    $(".security").css("background","none");
    $(".management").css("background","none");
    $(".analytics").css("background","none");
    $(".backend-logic").css("background","none");
    $(".push").css("background","none");
}
