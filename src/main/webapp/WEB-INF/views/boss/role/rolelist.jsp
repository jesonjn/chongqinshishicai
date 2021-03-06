<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>角色管理</title>
<!-- 引入Jquery -->
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.js"
	charset="utf-8"></script>
<script src="<%=basePath%>static/js/commonUtil.js"
	type="text/javascript"></script>
<%@ include file="../../common/easyUiInclude.jsp"%>

<script type="text/javascript">
	$(function() {
		$('#mydatagrid').datagrid({
			title : '角色列表信息',
			iconCls : 'icon-ok',
			pageSize : 10,//默认选择的分页是每页5行数据
			pageList : [ 5, 10, 15, 20 ],//可以选择的分页集合
			nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取
			striped : true,//设置为true将交替显示行背景。
			collapsible : true,//显示可折叠按钮
			toolbar:"#tb",//在添加 增添、删除、修改操作的按钮要用到这个
			url:'<%=basePath%>boss/role/ajax_role_list',//url调用Action方法
			loadMsg : '数据装载中......',
			singleSelect:true,//为true时只能选择单行
			fitColumns:true,//允许表格自动缩放，以适应父容器
			//sortName : 'xh',//当数据表格初始化时以哪一列来排序
			//sortOrder : 'desc',//定义排序顺序，可以是'asc'或者'desc'（正序或者倒序）。
			remoteSort : false,
 			 frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			} ] ], 
			pagination : true,//分页
			rownumbers : true,//行数
			columns:[[
		              {field:'roleName',title:'角色名称',width:90,align:'center'},  
			            {field:'descption',title:'角色描述',width:200,align:'center'},
			            {field:'createDate',title:'创建时间',width:90,align:'center',
				            formatter: function(value,row,index){
											var time = row.createDate;
											if(time !=''){
												return formatTime(time);
											}
							         	}
			            },
			            {field:'updateDate',title:'更新时间',width:90,align:'center',
				            formatter: function(value,row,index){
											var time = row.updateDate;
											if(time !=''){
												return formatTime(time);
											}
							         	}
			            }
			      ]]
		});	
		
	});
	
</script>

</head>
<body>
	<!-- 工具栏 -->
	<div id="tb" style="height: auto">
		<form id="queryForm"></form>
		<div>
			<a href="javascript:newMenu()" class="easyui-linkbutton"
				iconCls="icon-search" plain="true">新建</a> <a
				href="javascript:updateOrderDialog()" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true">修改</a> <a
				href="javascript:deleteOrder()" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true">删除</a>
		</div>
	</div>
	<div>
		<table id="mydatagrid"></table>
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 280px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post" novalidate accept-charset="utf-8"
			onsubmit="document.charset='utf-8'">
			<div class="fitem">
				<label>角色名称:</label> <input id="roleName" name="roleName"
					class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>角色描述:</label> <input id="descption" name="descption"
					class="easyui-textbox">
			</div>
			<div class="fitem">
			<label>菜单列表:</label> <br/>
			<c:forEach items="${requestScope.menus }" var="menus">
			 <input id="menus" name="menus" type="checkbox" value="${ menus.id}" class="easyui-textbox"/>${ menus.menu}<br/>
			</c:forEach>
			<input id="menu" name="menu"
					class="easyui-textbox" type="hidden">
			</div>
	</div>

	</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveMenu()" style="width: 90px">确定</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
var url;
function newMenu(){
	$('#dlg').dialog('open').dialog('setTitle','创建角色');
	$('#fm').form('clear');
	url = '<%=basePath%>boss/role/ajax_role_save';
		}

		function saveMenu() {
			alert("-----");
			var roleName = $("#roleName").val();
			var descption = $("#descption").val();
			  var spCodesTemp = "";
		      $('input:checkbox[name=menus]:checked').each(function(i){
		       if(0==i){
		        spCodesTemp = $(this).val();
		       }else{
		        spCodesTemp += (","+$(this).val());
		       }
		      });
		      $("#menu").val(spCodesTemp);
			if (roleName != "" ) {
				$('#fm').form('submit', {
					url : url,
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						var result = eval('(' + result + ')');
						if (result.sucess) {
							$('#dlg').dialog('close'); // close the dialog
							$('#mydatagrid').datagrid('reload'); // reload the user data
						} else {
							$.messager.show({
								title : '提醒',
								msg : "新增失败"
							});
						}
					}
				});
			}

		}
	</script>
</body>
</html>
