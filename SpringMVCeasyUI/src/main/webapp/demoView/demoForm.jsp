<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>springMVC demo</title>
</head>
<!-- ____________________________jquery________________________________ -->
<script type="text/JavaScript"
	src='<c:url value="/js/jQuery/jquery-3.2.1.min.js"/>'></script>
<!-- ____________________________end jquery____________________________ -->
<!-- ____________________________easyUI____________________________ -->
<link rel="stylesheet" type="text/css"
	href="<c:url value='/js/easyUI/jquery-easyui-1.6.5/themes/default/easyui.css'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/js/easyUI/jquery-easyui-1.6.5/themes/icon.css'/>">
<script type="text/javascript"
	src="<c:url value='/js/easyUI/jquery-easyui-1.6.5/jquery.easyui.min.js'/>"></script>
<!-- ____________________________end easyUI____________________________ -->
<body>
	<!-- ____________________________menu__________________________________ -->
	<a href="javascript:void(0)" id="mb" class="easyui-menubutton"
		data-options="menu:'#mm',iconCls:'icon-man'">Edit</a>
	<div id="mm" style="width: 150px;">
		<div class="menu-sep"></div>
		<div>profile</div>
		<div>experience</div>
		<div>profession</div>
		<div class="menu-sep"></div>
		<div>kick</div>
	</div>
	<a href="javascript:void(0)" id="mb" class="easyui-menubutton"
		data-options="iconCls:'icon-help'">help</a>
	<!-- _______________________end menu__________________________________ -->
	<!-- 	____________________________file tree____________________________ -->
	<div id="filetree"></div>
	<!-- 	____________________________end file tree____________________________ -->
	<!-- 	____________________________form____________________________ -->
	<div class="easyui-panel" title="easyUI eeeeezzzzzzzz"
		style="width: 300px; padding: 10px;">
		<form id='formDemo' method="post"
			action="<c:url value='/com/formDemo/handler/DemoHandler/getFormData.do'/>"
			enctype="multipart/form-data">
			<table class="table1">
				<tr>
					<td>name</td>
					<td><input class="f1 easyui-textbox" type="text" name="name"></td>
				</tr>
				<tr>
					<td>job</td>
					<td><input class="easyui-validatebox" type="text" name="job"></td>
				</tr>
				<tr>
					<td>RIP date</td>
					<td><input id="dd" class="easyui-datebox" required="required"
						name="date" data-options="formatter:myformatter"></td>
				</tr>
			</table>
			<div>image upload</div>
			<input name="file" class="f1 easyui-filebox" id="imgFile"></input> <input
				class="f1 easyui-filebox" name="file" id="imgFile"></input> <input
				type="submit" value="send" />
		</form>
	</div>
</body>
<script>
	var data;
	$(function() {
		$('#filetree').fileTree({
			root : '/some/folder/'
		}, function(file) {
			alert(file);
		});
		easyUI();
		$('#imgFile').on('change', fileChange);
		$('.submit').on('click', uploadImage);
	})
	// ________________________________easyUI________________________________
	function easyUI() {
		$('#formDemo').form({
			success : function(data) {
				$.messager.alert('Info', data, 'info');
			}
		});
	}
	function myformatter(date) {
		console.log(date.getFullYear());
		var y = date.getFullYear() - 1911;
		console.log("1st________" + y);
		var m = date.getMonth() + 1;
		var d = date.getDate();
		return y + '-' + (m < 10 ? ('0' + m) : m) + '-'
				+ (d < 10 ? ('0' + d) : d);
	}
	function myparser(s) {
		if (!s)
			return new Date();
		var ss = (s.split('-'));
		console.log(ss);
		var y = parseInt(ss[0], 10);
		var m = parseInt(ss[1], 10);
		var d = parseInt(ss[2], 10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
			console.log(new Date(y, m - 1, d));
			return new Date(y, m - 1, d);
		} else {
			return new Date();
		}
	}
	// ___________________________end easyUI________________________________
	function fileChange() {
		// 		files = e.target.files;
		data = new FormData($('#formDemo')[0]);
	}
	function uploadImage() {
		$
				.ajax({
					type : "POST",
					// 					enctype : 'multipart/form-data',
					url : "${pageContext.request.contextPath}/com/formDemo/handler/DemoHandler/processUpload.do",
					name : $(':input[name="name"]').val(),
					data : data,
					processData : false,
					contentType : false,
					cache : false,
					// 					timeout : 600000,
					success : function(data) {
						alert(data);
					}
				});//end post
		$('#formDemo').submit();
	}
</script>
</html>