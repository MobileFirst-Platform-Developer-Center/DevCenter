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
    
    // temp
    $(".analytics").attr("src","../assets/features/ios.svg");
    $(".push").attr("src","../assets/features/android.svg");
    $(".security").attr("src","../assets/features/android.svg");
    $(".backend-logic").attr("src","../assets/features/android.svg");
    $(".management").attr("src","../assets/features/android.svg");
    
    // Change background color for active feature
    $(".analytics").css("background","#c3e5f8");
    $(".push").css("background","white");
    $(".security").css("background","white");
    $(".backend-logic").css("background","white");
    $(".management").css("background","white");
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
    
    $(".analytics").css("background","white");
    $(".push").css("background","#c3e5f8");
    $(".security").css("background","white");
    $(".backend-logic").css("background","white");
    $(".management").css("background","white");
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
    
    $(".analytics").css("background","white");
    $(".push").css("background","white");
    $(".security").css("background","#c3e5f8");
    $(".backend-logic").css("background","white");
    $(".management").css("background","white");
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
    
    $(".analytics").css("background","white");
    $(".push").css("background","white");
    $(".security").css("background","white");
    $(".backend-logic").css("background","#c3e5f8");
    $(".management").css("background","white");
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
    
    $(".analytics").css("background","white");
    $(".push").css("background","white");
    $(".security").css("background","white");
    $(".backend-logic").css("background","white");
    $(".management").css("background","#c3e5f8");
});