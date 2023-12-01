<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/js/admin/index/index_main.js"></script>

<%-- <script>
const foods = new Map();
const foods2 = new Map();
const foods3 = new Map();
</script>
<%@ include file ="/admin/layouts/index/index_parsing.jsp" %>
<script>
foods.set("data_value", '<%=values.toString()%>')
foods.set("data_key", '<%=keys.toString() %>')
foods2.set("data_value2", '<%=values2.toString()%>')
foods2.set("data_key2", '<%=keys2.toString() %>')
foods3.set("data_value3", '<%=values3.toString()%>')
foods3.set("data_key3", '<%=keys3.toString() %>')
</script> --%>
<main class="mainContent">
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">차트 페이지</h1>
        <p class="lead text-body-secondary"></p>

      </div>
    </div>
  </section>

  <div class="album py-5 bg-body-tertiary">    
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 getMenuList">

<!-- not repeat div -->
      </div>
      
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/js/admin/index/chart/chart bar.js"></script>      
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<div class="chartBox">
<!-- 	<div>
		<canvas id="myChart" style="display: block; box-sizing: border-box; height: 300px; width: 1200px;" width="1200"></canvas>
	</div> -->
	
	<div>
		<canvas id="myChart3"  style="display: block; box-sizing: border-box; height: 232px; width: 696px;" width="696"></canvas>
	</div>
	
	<div>
		<canvas id="myChart2"  style="display: block; box-sizing: border-box; height: 232px; width: 696px;" width="696"></canvas>
	</div> 
	
	<div>
		<canvas id="myChart4" style="display: block; box-sizing: border-box; height: 232px; width: 696px;" width="696"></canvas>
		
	 <label for="startDate">Start Date:</label>
    	<input type="date" id="startDate">

    <label for="endDate">End Date:</label>
    	<input type="date" id="endDate">
		
		<button onclick="updateChart()">날짜 등록 </button>
	</div>
</div>  
                        
    </div>
  </div>
</main>
<script src="/docs/5.3/dist/js/bootstrap.bundle.min.js"></script>