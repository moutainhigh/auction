<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%
    String path = request.getContextPath() + "";
    String common = path + "/resources/";
%>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>${website.site_name }</title>
    <c:set var="path" value="<%=path%>"></c:set>
    <link rel='icon' href="<%=common%>/admin-favicon.ico" type="image/x-ico" />
    <link rel="stylesheet" href="<%=common%>layui/css/layui.css" media="all">
    <script src="<%=common%>/layui/layui.js" charset="utf-8"></script>
    <script src="<%=common%>/js/jquery-3.2.1.min.js" charset="utf-8"></script>
    <script src="<%=common%>/js/util.js" charset="utf-8"></script>
</head>
<body>
<div id="toolBar" style="margin-left: 10%">
    <%--分类:
    <div class="layui-inline">
        <select name="classify1" id="classify1" style="width: 168px;height: 33px;" lay-verify="">
            <option value="">请选择</option>
            <c:forEach items="${classifyList}" var="st">
                <option value="${st.id}">${st.name}</option>
            </c:forEach>
        </select>
    </div>--%>
    拍品名称:
    <div class="layui-inline">
        <input class="layui-input" id="productName" name="productName" autocomplete="off">
    </div>


    <div class="layui-inline">
        <button class="layui-btn layui-btn-radius" data-type="reload" id="btnSearch">
            <i class="layui-icon layui-anim layui-anim-scale">&#xe615;</i> 搜索
        </button>
    </div>
    <button class="layui-btn" data-type="getCheckData" id="getCheckData">添加</button>
</div>
<table class="layui-hide" id="manage-data" lay-filter="batchOn" style="width: 90%;">
</table>
<script src="<%=common%>/system/btns.js" charset="utf-8"></script>
<script src="<%=common%>/system/productManage/productManageList.js" charset="utf-8"></script>
<script type="text/javascript">

    var myId = "${parentId}";
    var path = "${path}";
    var table;
    var form;
    var saveUserRole;
    var saveRoleWindow;


    layui.use(['table','form','laydate'], function() {
        findBtns(null, "${parentId}");

        table = layui.table;
        form = layui.form;
        laydate = layui.laydate;

        laydate.render({
            elem: '#beginTime',
            type: 'datetime'
        });
        laydate.render({
            elem: '#endTime',
            type: 'datetime'
        });
        //监听表格复选框选择
        table.on('checkbox(batchOn)', function(obj){
            console.log(obj)
        });
        //监听工具条
        table.on('tool(batchOn)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                layer.msg('ID：'+ data.productId + ' 的查看操作');
            } else if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    console.log(data);
                });
            } else if(obj.event === 'edit'){
                layer.msg('编辑ID：'+ data.productId + ' 的查看操作');
            }
        });
        table.render({
            elem : '#manage-data',
            even : true,
            url : '${path}/auctionProduct/auctionlist',
            height : "full-78",
            method : 'post',
            page : { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout : [ 'prev', 'page', 'next', 'skip', 'count', 'limit' ],//自定义分页布局//,curr: 5 //设定初始在第 5 页
                groups : 5,//只显示 1 个连续页码
                limits : [ 10, 20, 50, 100, 200 ],
                first : "首页",
                theme : "#FF5722;",
                limit : 10,
                last : "尾页"

            },
            id : 'search',
            cols : [ [ {
                type : 'checkbox',
                fixed : 'left'
            }, {
                type : 'numbers',
                align : 'center',
                title : '序号',
                fixed : "center",
                width : '10%'
            },{
                field : 'id',
                title : '拍品ID',
                fixed : "center",
                width: '30%'
            },{
                field : 'productName',
                align : 'center',
                width : '30%',
                title : '拍品名称'
            }, {
                field : 'productPrice',
                title : '价格',
                align : 'center',
                width :'30%',
                templet : '<div>{{toProductPrice(d.productPrice)}}</div>'
            }
        ] ]
        });
        //执行重载
        table.reload('search', {
            page : {
                //重新从第 1 页开始
                page : 1
            },
            where : {
                type:1
            }
        });
        var $ = layui.$, active = {
            reload : function() {
                //执行重载
                table.reload('search', {
                    page : {
                        //重新从第 1 页开始
                        page : 1
                    },
                    where : {
                        productName : $('#productName').val(),

                        classifyId : $('#classify1').val(),

                        type:1
                    }
                });
            }
        };

        $('#getCheckData').on('click', function() {
            //获取选中数据
            var checkStatus = table.checkStatus('search');
            var  data = checkStatus.data;
            if(data.length == 1) {
                window.parent.document.getElementById("productId").setAttribute("value",data[0].id);
                window.parent.document.getElementById("selectProduct").textContent = data[0].productName;
                parent.layer.closeAll('iframe');
            }else if(data.length > 1){
                layer.msg('只能选中一个拍品', function() {});
            }else {
                layer.msg('未选中要操作的行', function() {});
            }
        });
        $('#btnSearch').on('click', function() {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';

        });
        $("#toolBar").keydown(function(event) {
            if (event.keyCode == 13) {
                refreshPage();
            }
        });
        refreshPage = function() {
            $('#btnSearch').trigger("click");
        }


    });

    function toProductPrice(productPrice) {
        return "¥"+productPrice;
    }
</script>
<script type="text/html" id="productStatusScript">
    {{#  if(d.status == 0 ){ }}
    未上架
    {{# } else if(d.status == 1) { }}
    已上架
    {{# } else if(d.status == 2) { }}
    未上架
    {{# } else if(d.status == 3) { }}
    未上架
    {{#  } else { }}
    未上架
    {{#  } }}
</script>

</body>
</html>