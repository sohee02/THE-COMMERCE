<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.test.commerce.user.domain.UserVO" %>
<%
    LocalDate today = LocalDate.now();
    LocalDate firstDayOfWeek = today.with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.SUNDAY));
    LocalDate lastDayOfWeek = today.with(java.time.temporal.TemporalAdjusters.nextOrSame(java.time.DayOfWeek.SATURDAY));
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 M월 d일");
    request.setAttribute("today", today.format(formatter));
    request.setAttribute("firstDayOfWeek", firstDayOfWeek.format(formatter));
    request.setAttribute("lastDayOfWeek", lastDayOfWeek.format(formatter));
%>

<c:set var="CP" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Mypage Test</title>
    <link rel="stylesheet" href="${CP}/resources/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="${CP}/resources/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${CP}/resources/vendors/jvectormap/jquery-jvectormap.css">
    <link rel="stylesheet" href="${CP}/resources/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="${CP}/resources/vendors/owl-carousel-2/owl.carousel.min.css">
    <link rel="stylesheet" href="${CP}/resources/vendors/owl-carousel-2/owl.theme.default.min.css">
    <link rel="stylesheet" href="${CP}/resources/css/style.css" >
    <link rel="shortcut icon" href="${CP}/resources/images/favicon.png" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="${CP}/resources/vendors/js/vendor.bundle.base.js"></script>
	<script src="${CP}/resources/vendors/progressbar.js/progressbar.min.js"></script>
	<script src="${CP}/resources/vendors/jvectormap/jquery-jvectormap.min.js"></script>
	<script src="${CP}/resources/vendors/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
	<script src="${CP}/resources/vendors/owl-carousel-2/owl.carousel.min.js"></script>
	<script src="${CP}/resources/js/off-canvas.js"></script>
	<script src="${CP}/resources/js/hoverable-collapse.js"></script>
	<script src="${CP}/resources/js/misc.js"></script>
	<script src="${CP}/resources/js/settings.js"></script>
	<script src="${CP}/resources/js/todolist.js"></script>
	<script src="${CP}/resources/js/dashboard.js"></script>
<title>Insert title here</title>
<style>
	body{
		background-color: #f7e9e8 !important;
	}
	.sidebar{
		background-color:#f7e9e8 !important;
		color:#514752;
	}
	 .card-body{
	        background-color:#fdce64;
	        border: 1px solid #fa9624;
	 }
	 .pieChart{
        max-width: 200px;
        max-height: 200px;
        margin: 10px; /* 차트 간격을 조절합니다. */
     }
     .chart-flex{
        display: flex;
        flex-wrap: wrap; /* 차트가 창 너비를 벗어날 경우 다음 줄로 넘어갑니다. */
        justify-content: space-between; /* 차트를 가로로 분배합니다. */
     }
       .calendar-container {
        display: none;
        position: absolute;
        border: 1px solid #ccc;
        background-color: #fff;
        padding: 10px;
        z-index: 1;  
        color: darkslategray;
    }

    .calendar-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .calendar-table {
        width: 100%;
        border-collapse: collapse;
    }

    .calendar-table th,
    .calendar-table td {
        text-align: center;
        padding: 8px;
        border: 1px solid #ccc;
    }

    .calendar-table th {
        background-color: #f2f2f2;
    }

    .calendar-table td:hover {
        cursor: pointer;
        background-color: #f2f2f2;
    }

    .current-month {
        font-weight: bold;
    }
    .current-date {
    background-color: #ee845c;
    color: white;
    border-radius: 50%;
	}
	.current-date:hover {
    background-color: #fc424a !important; /* hover 시 변경할 색상 */
    color: white; /* hover 시 변경할 글자 색상 */
    border-radius: 50%;
}

    #prevMonthButton,
    #nextMonthButton {
        background-color: transparent;
        border: none;
        cursor: pointer;
        outline: none;
    }
    .card-footer{
    	background-color: #fa9624;
    }
    .sidebar .sidebar-brand-wrapper{
    	background-color: #f7e9e8;
    }
    .navbar .navbar-menu-wrapper{
    	background-color: #f7e9e8;
    	color:#514752;
    }
    .navbar .navbar-menu-wrapper .navbar-nav.navbar-nav-right{
    
    }
</style>

<script>
function formatDate(date) {
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDate();

    // 달이나 일이 한 자리 수일 경우 앞에 0을 붙여줌
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;

    return year + '/' + month + '/' + day;
}
</script>
<script>	
function generateCalendar(year, month) {
    var calendarBody = $("#calendarBody");
    calendarBody.empty(); // 기존 내용 제거

    var currentDate = new Date(); // 현재 날짜 가져오기
    var daysInMonth = new Date(year, month, 0).getDate(); // 선택된 연도와 달의 일수

    var dayCounter = 1;
    for (var i = 0; i < 6; i++) {
        var row = $("<tr></tr>");
        for (var j = 0; j < 7; j++) {
            var cell = $("<td></td>");
            if (i === 0 && j < currentDate.getDay()) {
                // 앞의 빈 칸 처리
                cell.text("");
            } else if (dayCounter <= daysInMonth) {
                cell.text(dayCounter);
                dayCounter++;
                cell.click(function () {
                    // 날짜를 클릭했을 때 'yy/mm/dd' 형식으로 출력
                    var clickedDate = new Date(year, month - 1, $(this).text());
                    var formattedDate = formatDate(clickedDate);
                    // alert("날짜를 클릭했습니다: " + formattedDate);
                    console.log('formattedDate: ' + formattedDate);
                    window.location.href = "${CP }/nutrient/doRetrieveOneDay.do?regDt=" + formattedDate;
                });
            }
            row.append(cell);
        }
        calendarBody.append(row);
    }
    markCurrentDate(currentDate.getFullYear(), currentDate.getMonth() + 1, currentDate.getDate()); // 현재 날짜 표시
}

$(document).ready(function () {
    // 현재 년도와 월을 가져오기
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    var currentMonth = currentDate.getMonth() + 1;

    generateCalendar(currentYear, currentMonth);
    displayCurrentMonth(currentMonth); // 현재 월 표시
    markCurrentDate(currentDate.getDate()); // 현재 날짜 표시

    // 이전 달 버튼 클릭 시
    $("#prevMonthButton").click(function () {
        if (currentMonth === 1) {
            currentYear--;
            currentMonth = 12;
        } else {
            currentMonth--;
        }
        generateCalendar(currentYear, currentMonth);
        displayCurrentMonth(currentMonth); // 현재 월 표시
        markCurrentDate(0); // 현재 날짜 표시 제거
    });

    // 다음 달 버튼 클릭 시
    $("#nextMonthButton").click(function () {
        if (currentMonth === 12) {
            currentYear++;
            currentMonth = 1;
        } else {
            currentMonth++;
        }
        generateCalendar(currentYear, currentMonth);
        displayCurrentMonth(currentMonth); // 현재 월 표시
        markCurrentDate(0); // 현재 날짜 표시 제거
    });
});

function displayCurrentMonth(month) {
    var months = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
    $("#currentMonth").text(months[month - 1]);
}

function markCurrentDate(year, month, day) {
    // 현재 날짜의 셀을 찾아서 스타일을 적용
    var currentDate = new Date(year, month - 1, day);
    var formattedDate = formatDate(currentDate);
    $("#calendarBody td").each(function () {
        var cellDate = new Date(year, month - 1, parseInt($(this).text()));
        if (cellDate.getFullYear() === year && cellDate.getMonth() === month - 1 && cellDate.getDate() === day) {
            $(this).addClass("current-date");
        } else {
            $(this).removeClass("current-date");
        }
    });
}

function formatDate(date) {
    var year = date.getFullYear() % 100;
    var month = date.getMonth() + 1;
    var day = date.getDate();

    // 달이나 일이 한 자리 수일 경우 앞에 0을 붙여줌
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;

    return year + '/' + month + '/' + day;
}
</script>
<script>
            // 페이지 로드 후 실행되는 함수
$(document).ready(function () {
            // 사용자의 생년월일 데이터를 가져와서 계산
	var userBirthNumber = "${user.birth}";
	var age = calculateAge(userBirthNumber);

            // 계산된 만 나이를 출력
	var ageInfoElement = $("#ageInfo");
	ageInfoElement.html("<strong>나이</strong> " + age + "세");
});

        // 생년월일을 받아서 만 나이를 계산하는 함수
function calculateAge(birth) {
	var birthString = birth.toString();
	var twoDigitYear = parseInt(birthString.substr(0, 2), 10);

	var fullYear = (twoDigitYear >= 50) ? 1900 + twoDigitYear : 2000 + twoDigitYear;
	var month = parseInt(birthString.substr(2, 2), 10) - 1;
	var day = 1;

	var birthdate = new Date(fullYear, month, day);
	var currentDate = new Date();

	var age = currentDate.getFullYear() - birthdate.getFullYear();

    if (currentDate.getMonth() < birthdate.getMonth() ||
       (currentDate.getMonth() === birthdate.getMonth() && currentDate.getDate() < birthdate.getDate())) {
       		age--;
    }
 
    return age;
}
</script>
<script>
	var pastelColors = [
		    '#ABDEE6', // 연한 파랑
		    '#CBAACB', // 연한 보라
		    '#FFFFB5', // 연한 노랑
		    '#FFCCB6', // 연한 주황
		    '#F3B0C3'  // 연한 빨강
	];

	function generateNutrientPieChart(data, nutrientLabel, canvasId, colors, totalValue) {
	    var ctx = document.getElementById(canvasId).getContext('2d');
	    var percentage = (data / totalValue) * 100;
	    new Chart(ctx, {
	        type: 'pie',
	        data: {
	            labels: [nutrientLabel],
	            datasets: [{
	                data: [data, totalValue - data], // Remaining portion to complete the total
	                backgroundColor: colors.concat('#E0E0E0'), // Add a neutral color for the remaining portion
	                borderWidth: 1
	            }]
	        },
	        options: {
	            responsive: true,
	            maintainAspectRatio: false,
	            tooltips: {
	                callbacks: {
	                    label: function (tooltipItem, data) {
	                        var dataset = data.datasets[tooltipItem.datasetIndex];
	                        var currentValue = dataset.data[tooltipItem.index];
	                        return nutrientLabel + ": " + currentValue + "g (" + percentage.toFixed(2) + "%)";
	                    }
	                }
	            }
	        }
	    });
	}
	
	function getPastelColors(count) {
	    var colors = [];
	    for (var i = 0; i < count; i++) {
	        var color = "hsl(" + (360 * i / count) + ", 100%, 80%)";
	        colors.push(color);
	    }
	    return colors;
	}
	
	var totalDailyKcal = (${user.height} - 100) * 0.9 * ${user.activity};
	var totalDailyCarbo = (totalDailyKcal * 0.4) / 4;
	var totalDailyProtein = (totalDailyKcal * 0.4) / 4;
	var totalDailyFat = (totalDailyKcal * 0.2) / 9;
	var totalDailySugars = 30;

</script>
<script>
function generateCombinedLineChart(labels, kcalData, carbData, proteinData, fatData, sugarsData, canvasId) {
    var ctx = document.getElementById(canvasId).getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '칼로리',
                    data: kcalData,
                    borderColor: pastelColors[0], // 연한 파랑
                    backgroundColor: pastelColors[0],
                    borderWidth: 1
                },
                {
                    label: '탄수화물',
                    data: carbData,
                    borderColor: pastelColors[1], // 연한 보라
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderWidth: 1
                },
                {
                    label: '단백질',
                    data: proteinData,
                    borderColor: pastelColors[2], // 연한 노랑
                    backgroundColor: 'rgba(255, 206, 86, 0.2)',
                    borderWidth: 1
                },
                {
                    label: '지방',
                    data: fatData,
                    borderColor: pastelColors[3], // 연한 주황
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 1
                },
                {
                    label: '당류',
                    data: sugarsData,
                    borderColor: pastelColors[4], // 연한 빨강
                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                    borderWidth: 1
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
}

    
</script>
<script>
    const weekData = {
      labels: ['일', '월', '화', '수', '목', '금', '토'],
      datasets: [{
        label: '칼로리',
        data: [${weekKcal[0]}/totalDailyKcal*100, ${weekKcal[1]}/totalDailyKcal*100, ${weekKcal[2]}/totalDailyKcal*100, ${weekKcal[3]}/totalDailyKcal*100, ${weekKcal[4]}/totalDailyKcal*100, ${weekKcal[5]}/totalDailyKcal*100, ${weekKcal[6]}/totalDailyKcal*100],
        borderColor: 'rgb(255, 99, 132)',
        borderWidth: 3, 
        fill: false
      }, {
        label: '탄수화물',
        data: [${weekCarbo[0]}/totalDailyCarbo*100, ${weekCarbo[1]}/totalDailyCarbo*100, ${weekCarbo[2]}/totalDailyCarbo*100, ${weekCarbo[3]}/totalDailyCarbo*100, ${weekCarbo[4]}/totalDailyCarbo*100, ${weekCarbo[5]}/totalDailyCarbo*100, ${weekCarbo[6]}/totalDailyCarbo*100],
        borderColor: 'rgba(255, 255, 181, 1)',
        borderWidth: 3,
        fill: false
      }, {
        label: '단백질',
        data: [${weekProtein[0]}/totalDailyProtein*100, ${weekProtein[1]}/totalDailyProtein*100, ${weekProtein[2]}/totalDailyProtein*100, ${weekProtein[3]}/totalDailyProtein*100, ${weekProtein[4]}/totalDailyProtein*100, ${weekProtein[5]}/totalDailyProtein*100, ${weekProtein[6]}/totalDailyProtein*100],
        borderColor: 'rgba(153, 255, 194, 1)',
        borderWidth: 3,
        fill: false
      }, {
        label: '지방',
        data: [${weekFat[0]}/totalDailyFat*100, ${weekFat[1]}/totalDailyFat*100, ${weekFat[2]}/totalDailyFat*100, ${weekFat[3]}/totalDailyFat*100, ${weekFat[4]}/totalDailyFat*100, ${weekFat[5]}/totalDailyFat*100, ${weekFat[6]}/totalDailyFat*100],
        borderColor: 'rgba(153, 194, 255, 1)',
        borderWidth: 3,
        fill: false 
      }, {
        label: '당류',
        data: [${weekSugars[0]}/totalDailySugars*100, ${weekSugars[1]}/totalDailySugars*100, ${weekSugars[2]}/totalDailySugars*100, ${weekSugars[3]}/totalDailySugars*100, ${weekSugars[4]}/totalDailySugars*100, ${weekSugars[5]}/totalDailySugars*100, ${weekSugars[6]}/totalDailySugars*100],
        borderColor: 'rgba(234, 147, 255, 1)',
        borderWidth: 3,
        fill: false
      }]
    };

    document.addEventListener('DOMContentLoaded', function () {
        const ctx = document.getElementById('weeklyChart').getContext('2d');
        const weeklyChart = new Chart(ctx, {
            type: 'line',
            data: weekData,
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    });
</script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const addBtn = document.querySelector("#add");
    const moveToModBtn = document.querySelector("#moveToMod");
    const logoutBtn = document.querySelector("#logout");
    const foodRows = document.querySelectorAll("#foodTable>tbody>#trId");
    
    foodRows.forEach(function (row) {
        row.addEventListener('dblclick', function(e) {
         let cells = row.getElementsByTagName("td");
         const foodName = cells[1].innerText;
         const code = cells[3].innerText;
         const regDt = cells[4].innerText;
         const id = '${user.id}';
         console.log('foodName:'+ foodName);
         console.log('code:'+ code);
         console.log('regDt:'+ regDt);
         console.log('id:'+ id);
                         
         if(confirm(foodName + '삭제 하시겠습니까?') == false) return;

         $.ajax({
             type: "GET",
             url:"/bdm/nutrient/doDelete.do",
             asyn:"true",
             dataType:"html",
             data:{
             	id: id,
             	code: code,
             	regDt: regDt
             },
             success:function(data){//통신 성공     
                alert('삭제 되었습니다.');
                window.location.href = "/bdm/nutrient/doRetrieveOneDay.do";
             },
             error:function(data){//실패시 처리
                 console.log("error:"+data);
             },
             complete:function(data){//성공/실패와 관계없이 수행!
                 console.log("complete:"+data);
             }
         });
        });
    });
    
    addBtn.addEventListener("click", function (e) {
        console.log("moveToNutBTN")
        window.location.href = "/bdm/nutrient/moveToNut.do";
    });
    
    moveToModBtn.addEventListener("click", function(e){
    	window.location.href = "/bdm/user/moveToMod.do";
    });
    
    logoutBtn.addEventListener("click", function(e){
    	$.ajax({
            type: "GET",
            url:"/bdm/beforeMain/doLogout.do",
            asyn:"true",
            dataType:"html",
            data:{
            },
            success:function(data){//통신 성공     
               alert('로그아웃 되었습니다.');
            },
            error:function(data){//실패시 처리
                console.log("error:"+data);
            },
            complete:function(data){//성공/실패와 관계없이 수행!
                console.log("complete:"+data);
            }
        });
    });

    $(document).ready(function () {
        $("#calendarButton").click(function () {
            $("#calendar").toggle();
            var currentYear = new Date().getFullYear();
            var currentMonth = new Date().getMonth() + 1;
            generateCalendar(currentYear, currentMonth);
        });
    });
    
 <c:if test="${not empty oneDay}">
     // Generate pie charts for each nutrient
     var colors = getPastelColors(5);
     generateNutrientPieChart(${oneDay.kcal }, '칼로리', 'kcalDayChart', colors.slice(0, 1), totalDailyKcal);
     generateNutrientPieChart(${oneDay.carbohydrate}, '탄수화물', 'carbDayChart', colors.slice(1, 2), totalDailyCarbo);
     generateNutrientPieChart(${oneDay.protein}, '단백질', 'proteinDayChart', colors.slice(2, 3), totalDailyProtein);
     generateNutrientPieChart(${oneDay.fat}, '지방', 'fatDayChart', colors.slice(3, 4), totalDailyFat);
     generateNutrientPieChart(${oneDay.sugars}, '당류', 'sugarsDayChart', colors.slice(4, 5), totalDailySugars);
    </c:if>
});
</script>
</head>
<body>
    <%
        UserVO sessionData = (UserVO) session.getAttribute("user");
        // 위에서 선언한 변수들을 사용
        double totalDailyKcal = ((sessionData.getHeight() - 100) * 0.9 * sessionData.getActivity());
        double totalDailyCarbo = Math.round((totalDailyKcal * 0.4) / 4 * 100.0) / 100.0;
        double totalDailyProtein = Math.round((totalDailyKcal * 0.4) / 4 * 100.0) / 100.0;
        double totalDailyFat = Math.round((totalDailyKcal * 0.2) / 9 * 100.0) / 100.0;
        int totalDailySugars = 30;
    %>
    <c:set var="totalDailyKcal" value="<%= totalDailyKcal %>" />
    <c:set var="totalDailyCarbo" value="<%= totalDailyCarbo %>" />
    <c:set var="totalDailyProtein" value="<%= totalDailyProtein %>" />
    <c:set var="totalDailyFat" value="<%= totalDailyFat %>" />
    <c:set var="totalDailySugars" value="<%= totalDailySugars %>" />
    
    <div class ="container-scroller">
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
            <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
                <a class="sidebar-brand brand-logo" href="index.jsp" src="${CP}/resources/images/logo.png" alt="logo" ></a>
                <a class="sidebar-brand brand-logo-mini" href="index.html"><img src="${CP}/resources/images/logo-mini.png" alt="logo" /></a>
            </div>
            <ul class="nav">
                <li class="nav-item menu-item">
                    <span class="nav-link">Navigation</span>
                </li>
                <li class="nav-item menu-item">
                    <a class="nav-link" href="/bdm/beforeMain/popSearchWord.do">
                        <span class="menu-icon">
                            <i class="mdi mdi-speedometer"></i>
                        </span>
                        <span class="menu-title">메인화면</span>
                    </a>    
                </li><!--메인화면 이동-->
                <li class="nav-item menu-item">
                    <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
                        <span class="menu-icon">
                            <i class="mdi mdi-laptop"></i>
                        </span>
                        <span class="menu-title">게시판</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="ui-basic">
                        <ul class="nav flex-column sub-menu">
                          <li class="nav-item"> <a class="nav-link" href="/bdm/bulletin/doRetrieve.do">자유게시판</a></li>
                          <li class="nav-item"> <a class="nav-link" href="/bdm/notice/doRetrieve.do">공지사항</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item menu-items">
                    <a class="nav-link" href="/bdm/news/doRetrieve.do">
                      <span class="menu-icon">
                        <i class="mdi mdi-playlist-play"></i>
                      </span>
                      <span class="menu-title">뉴스</span>
                    </a>
                </li>
            </ul><!--nav-->
        </nav><!-- sidebar-->
        <div class="container-fluid page-body-wrapper">
            <nav class="navbar p-0 fixed-top d-flex flex-row">
                <div class="navbar-brand-wrapper d-flex d-lg-none align-items-center justify-content-center">
                  <a class="navbar-brand brand-logo-mini" href=""><img src="${CP}/resources/images/logo-mini.png" alt="logo" /></a>
                </div>
                <div class="navbar-menu-wrapper flex-grow d-flex align-items-stretch">
                    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                        <span class="mdi mdi-menu"></span>
                    </button>
                    <ul class="navbar-nav navbar-nav-right">
                        <li class="nav-item dropdown">
                            <a class="nav-link" id="profileDropdown" href="#" data-toggle="dropdown">
                            <div class="navbar-profile">
                                <img class="img-xs rounded-circle" src="${CP}/resources/images/faces/face15.jpg" alt="">
                                <p class="mb-0 d-none d-sm-block navbar-profile-name">${user.name}</p>
                                <i class="mdi mdi-menu-down d-none d-sm-block"></i>
                            </div>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="profileDropdown">
                                <h6 class="p-3 mb-0">Profile</h6>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item preview-item">
                                    <div class="preview-thumbnail">
                                        <div class="preview-icon bg-dark rounded-circle">
                                            <i class="mdi mdi-settings text-success"></i>
                                        </div>
                                    </div>
                                    <div class="preview-item-content">
                                    <p class="preview-subject mb-1" id = "moveToMod">Settings</p>
                                    </div>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item preview-item">
                                    <div class="preview-thumbnail">
                                        <div class="preview-icon bg-dark rounded-circle">
                                            <i class="mdi mdi-logout text-danger"></i>
                                        </div>
                                    </div>
                                    <div class="preview-item-content">
                                        <p class="preview-subject mb-1" id = "logout">Log out</p>
                                    </div>
                                </a>
                                <div class="dropdown-divider"></div>
                                <p class="p-3 mb-0 text-center">Advanced settings</p>
                            </div>
                        </li>
                    </ul>
                    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
                        <span class="mdi mdi-format-line-spacing"></span>
                    </button>
                </div> 
            </nav><!--header-->
            <div class="main-panel">
                <div class="container mt-4">
                    <div class="row ">
                        <!-- 왼쪽: 프로필 사진 -->
                        <div class="col-md-3">
                            <div class="card h-100">
                                <div class="card-body d-flex justify-content-center align-items-center">
                                    <img src="${CP}/resources/images/faces/face14.jpg" alt="프로필 사진" class="profile-img img-fluid img-thumbnail">
                                </div>
                                <div class="card-footer text-center">
                                    <h5 class="card-title">프로필</h5>
                                </div>
                            </div>    
                        </div>
                        <!-- 오른쪽: 개인 정보 -->
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <h2>개인 정보</h2>
                                    <p><strong>이름    </strong>${user.name}</p>
                                    <p id="ageInfo"></p>
                                    <p><strong>키      </strong> ${user.height} cm</p> 
                                    <p><strong>몸무게  </strong>${user.weight} kg</p>
                                    <!-- 추가적인 개인 정보를 나열할 수 있습니다. -->
                                </div>

                            </div>
                        </div> 
                        <div class="card_no_bg col-md-3">
                            <button class="btn btn-primary full_buton" id="add"><strong>먹은음식 추가하기</strong></button>
                        </div>
                    </div>
                   
                    <div class="row mdi-arrow-top-right">
                        <div class="col-lg-12 grid-margin stretch-card">
                            <div class="card">
                              <div class="card-body">
	                                <div>
	                                    <h2>일일 섭취량</h2>
									    <h4 class="card-title">${convertedDate}</h4>
									    <button id="calendarButton">달력 열기</button>
									    <span>*예전 기록이 궁금하다면 클릭해서 해당 날짜로 이동*</span>
									    <!-- 달력 -->
									    <div id="calendar" class="calendar-container">
										    <div class="calendar-header">
										        <button id="prevMonthButton">이전 달</button>
										        <span id="currentMonth">2월</span>
										        <button id="nextMonthButton">다음 달</button>
										    </div>
										    <table class="calendar-table">
										        <thead>
										            <tr>
										                <th>일</th>
										                <th>월</th>
										                <th>화</th>
										                <th>수</th>
										                <th>목</th>
										                <th>금</th>
										                <th>토</th>
										            </tr>
										        </thead>
										        <tbody id="calendarBody">
										        </tbody>
										    </table>
										</div>
									</div>
	                                 <div class="chart-flex col-md-12">
		                                 <canvas id="kcalDayChart" class="pieChart col-md-4"></canvas>
		                                 <canvas id="carbDayChart" class="pieChart col-md-4"></canvas>
		                                 <canvas id="proteinDayChart" class="pieChart col-md-4"></canvas> 
		                                 <canvas id="fatDayChart" class="pieChart col-md-4"></canvas>
		                                 <canvas id="sugarsDayChart" class="pieChart col-md-4"></canvas>
	                     			 </div>
	                     			 <!-- FeedBack 부분 시작 -->
	                     			 <table class = "table table-bordered border-primary table-hover table-striped" id = "foodTable">
                                        <thead>
                                            <tr>
                                                <th scope = "col" class = "text-center">영양소</th>
                                                <th scope = "col" class = "text-center">상태</th>
                                                <th scope = "col" class = "text-center">현황</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
		                                        <td class="text-center">
		                                            <c:out value="열량" escapeXml="true" />
		                                        </td>
		                                        <c:choose>
		                                          <c:when test="${totalDailyKcal > oneDay.kcal}">
			                                          <td class="text-center">
			                                            <c:out value="부족" escapeXml="true" />
			                                          </td>
		                                          </c:when>
		                                          <c:otherwise>
		                                              <td class="text-center">
                                                        <c:out value="초과" escapeXml="true" />
                                                      </td>
		                                          </c:otherwise>
		                                        </c:choose>
		                                        <td class="text-center">
		                                            <c:out value= "${totalDailyKcal}g 중 ${oneDay.kcal}g 섭취" escapeXml="true" />
		                                        </td>
		                                    </tr>
		                                    <tr>
                                                <td class="text-center">
                                                    <c:out value="탄수화물" escapeXml="true" />
                                                </td>
                                                <c:choose>
                                                  <c:when test="${totalDailyCarbo > oneDay.carbohydrate}">
                                                      <td class="text-center">
                                                        <c:out value="부족" escapeXml="true" />
                                                      </td>
                                                  </c:when>
                                                  <c:otherwise>
                                                      <td class="text-center">
                                                        <c:out value="초과" escapeXml="true" />
                                                      </td>
                                                  </c:otherwise>
                                                </c:choose>
                                                <td class="text-center">
                                                    <c:out value="${totalDailyCarbo}g 중 ${oneDay.carbohydrate}g 섭취" escapeXml="true" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <c:out value="단백질" escapeXml="true" />
                                                </td>
                                                <c:choose>
                                                  <c:when test="${totalDailyProtein > oneDay.protein}">
                                                      <td class="text-center">
                                                        <c:out value="부족" escapeXml="true" />
                                                      </td>
                                                  </c:when>
                                                  <c:otherwise>
                                                      <td class="text-center">
                                                        <c:out value="초과" escapeXml="true" />
                                                      </td>
                                                  </c:otherwise>
                                                </c:choose>
                                                <td class="text-center">
                                                    <c:out value="${totalDailyProtein}g 중 ${oneDay.protein}g 섭취" escapeXml="true" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <c:out value="지방" escapeXml="true" />
                                                </td>
                                                <c:choose>
                                                  <c:when test="${totalDailyFat > oneDay.fat}">
                                                      <td class="text-center">
                                                        <c:out value="부족" escapeXml="true" />
                                                      </td>
                                                  </c:when>
                                                  <c:otherwise>
                                                      <td class="text-center">
                                                        <c:out value="초과" escapeXml="true" />
                                                      </td>
                                                  </c:otherwise>
                                                </c:choose>
                                                <td class="text-center">
                                                    <c:out value="${totalDailyFat}g 중 ${oneDay.fat}g 섭취" escapeXml="true" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <c:out value="당류" escapeXml="true" />
                                                </td>
                                                <c:choose>
                                                  <c:when test="${totalDailySugars > oneDay.sugars}">
                                                      <td class="text-center">
                                                        <c:out value="부족" escapeXml="true" />
                                                      </td>
                                                  </c:when>
                                                  <c:otherwise>
                                                      <td class="text-center">
                                                        <c:out value="초과" escapeXml="true" />
                                                      </td>
                                                  </c:otherwise>
                                                </c:choose>
                                                <td class="text-center">
                                                    <c:out value="${totalDailySugars}g 중 ${oneDay.sugars}g 섭취" escapeXml="true" />
                                                </td>
                                            </tr>
                                        </tbody>
                                     </table>
                                     <br/><br/>
	                     			 <!-- FeedBack 부분 끝 -->
	                     			 <table class = "table table-bordered border-primary table-hover table-striped" id = "foodTable">
							            <thead>
							                <tr>
							                    <th scope = "col" class = "text-center" style="display: none;">divs</th>
							                    <th scope = "col" class = "text-center">NO</th>
							                    <th scope = "col" class = "text-center">음식명</th>
							                    <th scope = "col" class = "text-center">섭취량</th>
							                </tr>
							            </thead>
							            <tbody>
							                <c:choose>
											    <c:when test="${not empty ateList}">
											        <c:set var="morning" value="false"/>
											        <c:set var="morlun" value="false"/>
											        <c:set var="lunch" value="false"/>
											        <c:set var="lundin" value="false"/>
											        <c:set var="dinner" value="false"/>
											        <c:set var="night" value="false"/>
											        <c:set var="etc" value="false"/>
											        <c:forEach var="vo" items="${ateList}" varStatus="status">
											            <c:choose>
											                <c:when test="${vo.code eq 1}">
											                    <c:if test="${!morning}">
											                        <tr>
											                            <td colspan="4" class="text-center">아침</td>
											                        </tr>
											                        <c:set var="morning" value="true"/>
											                    </c:if>
											                </c:when>
											                <c:when test="${vo.code eq 2}">
                                                                <c:if test="${!morlun}">
                                                                    <tr>
                                                                        <td colspan="4" class="text-center">아점</td>
                                                                    </tr>
                                                                    <c:set var="morlun" value="true"/>
                                                                </c:if>
                                                            </c:when>
											                <c:when test="${vo.code eq 3}">
											                    <c:if test="${!lunch}">
											                        <tr>
											                            <td colspan="4" class="text-center">점심</td>
											                        </tr>
											                        <c:set var="lunch" value="true"/>
											                    </c:if>
											                </c:when>
											                <c:when test="${vo.code eq 4}">
                                                                <c:if test="${!lundin}">
                                                                    <tr>
                                                                        <td colspan="4" class="text-center">점저</td>
                                                                    </tr>
                                                                    <c:set var="lundin" value="true"/>
                                                                </c:if>
                                                            </c:when>
											                <c:when test="${vo.code eq 5}">
											                    <c:if test="${!dinner}">
											                        <tr>
											                            <td colspan="4" class="text-center">저녁</td>
											                        </tr>
											                        <c:set var="dinner" value="true"/>
											                    </c:if>
											                </c:when>
											                <c:when test="${vo.code eq 6}">
                                                                <c:if test="${!night}">
                                                                    <tr>
                                                                        <td colspan="4" class="text-center">야식</td>
                                                                    </tr>
                                                                    <c:set var="night" value="true"/>
                                                                </c:if>
                                                            </c:when>
                                                            <c:when test="${vo.code eq 7}">
                                                                <c:if test="${!etc}">
                                                                    <tr>
                                                                        <td colspan="4" class="text-center">간식</td>
                                                                    </tr>
                                                                    <c:set var="etc" value="true"/>
                                                                </c:if>
                                                            </c:when>
											            </c:choose>
											            <tr id = "trId">
											                <td class="text-center"><c:out value="${status.index + 1}" escapeXml="true"/></td>
											                <td class="text-center"><c:out value="${vo.name}" escapeXml="true"/></td>
											                <td class="text-center"><c:out value="${vo.amount}인분" escapeXml="true"/></td>
											                <td style="display: none;"><c:out value="${vo.code}" /></td>
											                <td style="display: none;"><c:out value="${vo.regDt}" /></td>
											            </tr>
											        </c:forEach>
											    </c:when>
											    <c:otherwise>
											        <tr>
											            <td colspan="99" class="text-center">섭취한 음식이 없습니다.</td>
											        </tr>
											    </c:otherwise>
											</c:choose>
							            </tbody>
							        </table>
							        <br/><br/>
							        <h2>주간 섭취량</h2>
                                    <div class="chart-flex col-md-12"> 
                                        <canvas id="weeklyChart" class="weeklyChart col-md-12"></canvas>
                                    </div>
                                </div>
                            </div>
                            
                          </div>
                    </div>  
                </div>
            </div>
            
        </div><!--page-body-wrapper -->
    </div><!--container-->
</body>
</html>