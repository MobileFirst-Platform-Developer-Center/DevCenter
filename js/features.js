// Features page navigation
$(".feature-analytics").css("display", "block");

$(".feature-analytics-img").on("click", function() {
    $(".feature-analytics").css("display","block");
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-management").css("display","none");
    
    $(".analytics").attr("src","../assets/features/ios.svg");
    $(".push").attr("src","../assets/features/android.svg");
    $(".security").attr("src","../assets/features/android.svg");
    $(".backend-logic").attr("src","../assets/features/android.svg");
    $(".management").attr("src","../assets/features/android.svg");
});

$(".feature-push-img").on("click", function() {
    $(".feature-analytics").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-push").css("display","block");
    $(".feature-management").css("display","none");
    
    $(".analytics").attr("src","../assets/features/android.svg");
    $(".push").attr("src","../assets/features/ios.svg");
    $(".security").attr("src","../assets/features/android.svg");
    $(".backend-logic").attr("src","../assets/features/android.svg");
    $(".management").attr("src","../assets/features/android.svg");
});

$(".feature-security-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-management").css("display","none");
    $(".feature-security").css("display","block");
    
    $(".analytics").attr("src","../assets/features/android.svg");
    $(".push").attr("src","../assets/features/android.svg");
    $(".security").attr("src","../assets/features/ios.svg");
    $(".backend-logic").attr("src","../assets/features/android.svg");
    $(".management").attr("src","../assets/features/android.svg");
});

$(".feature-backend-logic-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-backend-logic").css("display","block");
    $(".feature-management").css("display","none");
    
    $(".analytics").attr("src","../assets/features/android.svg");
    $(".push").attr("src","../assets/features/android.svg");
    $(".security").attr("src","../assets/features/android.svg");
    $(".backend-logic").attr("src","../assets/features/ios.svg");
    $(".management").attr("src","../assets/features/android.svg");
});

$(".feature-management-img").on("click", function() {
    $(".feature-push").css("display","none");
    $(".feature-security").css("display","none");
    $(".feature-backend-logic").css("display","none");
    $(".feature-analytics").css("display","none");
    $(".feature-management").css("display","block");
    
    $(".analytics").attr("src","../assets/features/android.svg");
    $(".push").attr("src","../assets/features/android.svg");
    $(".security").attr("src","../assets/features/android.svg");
    $(".backend-logic").attr("src","../assets/features/android.svg");
    $(".management").attr("src","../assets/features/ios.svg");
});