<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_update_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>							
						</div>
						<div class="form-group">
							<label for="email_update_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control" id="email_update_input"
									placeholder="email@163.com">
								<span id="helpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">男
								</label>
								<label class="radio-inline">
									<input type="radio" name="gender" id="gender2_update_input" value="F">女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select name="dId" class="form-control" id="dept_update_select"></select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control" id="empName_add_input"
									placeholder="empName">
								<span id="helpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control" id="email_add_input"
									placeholder="email@163.com">
								<span id="helpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
								</label>
								<label class="radio-inline">
									<input type="radio" name="gender" id="gender2_add_input" value="F">女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select name="dId" class="form-control" id="dept_add_select"></select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_batch_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emp_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字 -->
			<div class="col-md-6" id="page_info"></div>
			<!-- 分页条信息 -->
			<dir class="col-md-6" id="nav_info">

			</dir>
		</div>
	</div>
	<script type="text/javascript">
	
		var totalRecord, currentPage;
		
		$(function() {
			to_page(1);
		});

		function build_emps_table(result) {
			$("#emp_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkboxTd = $("<td><input type='checkbox' class='check_item' /></td>")
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var empGenderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var empEmailTd = $("<td></td>").append(item.email);
				var empDeptNameTd = $("<td></td>").append(
						item.department.deptName);
				/*
				<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
				 */
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append("编辑");
				editBtn.attr("edit-id", item.empId);

				/*
					<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
				 */
				var deleteBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						"删除");

				deleteBtn.attr("del-id", item.empId);
				 
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						deleteBtn);

				$("<tr></tr>").append(checkboxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(empGenderTd)
					.append(empEmailTd)
					.append(empDeptNameTd)
					.append(btnTd)
					.appendTo("#emp_table tbody");
			})
		}

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					build_emps_table(result);

					build_page_info(result);

					build_page_nav(result);
				}
			});
		}

		function build_page_info(result) {
			$("#page_info").empty();
			//当前  页, 总  页, 总  条记录
			$("#page_info").append(
					"当前第 " + result.extend.pageInfo.pageNum + " 页, 共 "
							+ result.extend.pageInfo.pages + " 页, 共 "
							+ result.extend.pageInfo.total + " 条记录");
			
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}

		/*
			<nav aria-label="Page navigation">
			  <ul class="pagination">
			  	<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
			    <li>
			      <a href="#" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <li><a href="#">1</a></li>
			    <li>
			      <a href="#" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav>
		 */
		function build_page_nav(result) {
			$("#nav_info").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append($("<span></span>").append("&laquo;"))
							.attr("href", "#"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append($("<span></span>").append("&raquo;"))
							.attr("href", "#"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("尾页").attr("href", "#"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
			}

			ul.append(firstPageLi).append(prePageLi);

			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {

				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});

			ul.append(nextPageLi).append(lastPageLi);

			var navEle = $("<nav></nav>").append(ul);

			navEle.appendTo("#nav_info");
		}
		 
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		 
		 /* 点击新增按钮弹出模态框 */
		$("#emp_add_modal_btn").click(function() {
			//清除表单数据(表单完整重置：表单内容、表单样式)
			reset_form("#empAddModal form");
			//$("#empAddModal form")[0].reset();
			
			//发送 ajax 请求，查出部门信息，显示在下拉列表中
			getDepts("#dept_add_select");
			
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});
		 
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success: function(result){
					//{"code":100,"msg":"处理成功!",
						//"extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
					//console.log(result);
					//显示部门信息在下拉列表中
					//$("#dept_add_select").append("")
					$.each(result.extend.depts, function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//校验表单数据
		function validate_add_form(){
			//1. 拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input", "success", "");
			}
			
			//2. 校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input", "error", "前端：邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}
		
		function show_validate_msg(ele, status, msg){
			//应该清空这个元素之前的样式
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkempname",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input", "success", "用户名可用");
						$("#emp_save_btn").attr("ajax-va", "success");
					}else{
						show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va", "error");
					}
				}
			});
		});
		
		$("#emp_save_btn").click(function(){
			//1. 模态框中填写的表单数据交给服务器进行保存
			
			if(!validate_add_form()){
				return false;
			}
			
			if($(this).attr("ajax-va") == "error"){
				return false;
			}
			
			//2. 发送 ajax 请求保存员工
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code == 100){
						//员工保存成功：
						//1. 关闭模态框
						$("#empAddModal").modal('hide');
						
						//2. 来到最后一页，显示保存的员工信息
						//发送 ajax 请求显示最后一页数据
						to_page(totalRecord);
					}else{
						//console.log(result);
						if(undefined != result.extend.errorFields.email){
							show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
						}
					}
				}
			});
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"GET",
				success:function(result){
					//console.log(result);
					//{"code":100,"msg":"处理成功!",
					//"extend":{"emp":{"empId":1,"empName":"Jerry","gender":"M","email":"Jerry@163.com","dId":1,"department":null}}}
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name='gender']").val([empData.gender]);
					$("#dept_update_select").val([empData.dId]);
				}
			});
		}
		
		$(document).on("click", ".edit_btn", function(){
			//alert("edit");
			reset_form("#empUpdateModal form");
			
			getDepts("#dept_update_select");
			
			getEmp($(this).attr("edit-id"));
			
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
			
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});
		
		$("#emp_update_btn").click(function(){
			//校验邮箱
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){				
				show_validate_msg("#email_update_input", "error", "前端：邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input", "success", "");
			}
			
			var empId = $("#emp_update_btn").attr("edit-id");
			
			$.ajax({
				url:"${APP_PATH}/emp/" + empId,
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//console.log(result.msg);
					$("#empUpdateModal").modal('hide');
					to_page(currentPage);
				}
			});
		});
		
		$(document).on("click", ".delete_btn", function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确定要删除【"+ empName +"】吗?")){
				$.ajax({
					url:"${APP_PATH}/emp/" + $(this).attr("del-id"),
					type:"DELETE",
					success:function(result){
						//console.log(result.msg);
						to_page(currentPage);	
					}					
				});
			}
		});
		
		$("#check_all").click(function(){
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		
		$(document).on("click", ".check_item", function(){
			var allItemChecked = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked", allItemChecked);
		});
		
		$("#emp_delete_batch_btn").click(function(){
			var empsName = "";
			var del_ids = "";
			$.each($(".check_item:checked"), function(){
				empsName += $(this).parents("tr").find("td:eq(2)").text() + ",";
				del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			
			empsName = empsName.substring(0, empsName.length-1);
			del_ids = del_ids.substring(0, del_ids.length-1);
			
			if(confirm("确定要删除【"+ empsName +"】吗?")){
				$.ajax({
					url:"${APP_PATH}/emp/" + del_ids,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
	</script>
</body>
</html>