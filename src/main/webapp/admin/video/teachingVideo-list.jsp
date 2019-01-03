<%--
  Created by IntelliJ IDEA.
  User: heze
  Date: 18-12-28
  Time: 下午1:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/lib/html5shiv.js"></script>
    <script type="text/javascript" src="/lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/css/style.css"/>
    <!--[if IE 6]>
    <script type="text/javascript" src="/lib/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>录像列表</title>
</head>

<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 教学录像 <span
        class="c-gray en">&gt;</span>
    教学录像 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px"
            href="javascript:location.replace(location.href);"
            title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <form action="/ResourceServlet.do" class="text-c" method="post">
        <input type="hidden" name="resType" value="2"/>
        <input type="hidden" name="type" value="selectByName"/>
        <input type="text" name="search" placeholder=" 录像名称" style="width:250px" class="input-text">
        <input name="" id="" class="btn btn-success" type="submit">
    </form>
    <!-- TO-DO:实现批量删除 -->
    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="data_del()" class="btn btn-danger radius"><i
            class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" onclick="teachingVideo_add('添加录像','/admin/video/teachingVideo-add.jsp')"
                                                          href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加录像</a></span> <span class="r">共有数据：<strong>${sessionScope.resourceList.size()}</strong> 条</span>
    </div>
    <div class="mt-20">
        <table id="coursewrae-table" class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
            <tr class="text-c">
                <th width="40"><input type="checkbox" name="box" value="1"></th>
                <th width="80">ID</th>
                <th width="70">文件名称</th>
                <th width="70">文件大小</th>
                <th width="150">更新时间</th>
                <th width="60">发布状态</th>
                <th width="100">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${sessionScope.resourceList}" var="resource" varStatus="status">
                <tr class="text-c">
                    <td><input type="checkbox" name="box" value="1"></td>
                    <td>${resource.id}</td>
                    <td style="text-align: left">
                            <%--<img src="/images/teachResource/PPT.png">--%>
                        <a href="${resource.resPath}" download="${resource.resName}">${resource.resName}</a>
                    </td>
                    <td><c:out value="${10000}"/></td>
                    <td><c:out value="${resource.resTime}"/></td>

                    <td class="td-status">
                        <c:choose>
                            <c:when test="${resource.isCheck == '0'}">
                                <span class="label label-default radius">下架</span>
                            </c:when>
                            <c:when test="${resource.isCheck == '1'}">
                                <span class="label label-success radius">已发布</span>
                            </c:when>
                        </c:choose>
                    </td>

                    <td class="td-manage">
                        <a style="text-decoration:none" href="javascript:;" onClick="
                        <c:choose>
                        <c:when test="${resource.isCheck=='0'}">teachingVideo_start(this, ${resource.id})"  title="发布"</c:when>
                           <c:when test="${resource.isCheck=='1'}">teachingVideo_stop(this, ${resource.id})"  title="下架"</c:when>
                        </c:choose>
                        >
                        <c:choose>
                            <c:when test="${resource.isCheck == '0'}">
                                <i class="Hui-iconfont">&#xe603;</i>
                            </c:when>
                            <c:when test="${resource.isCheck == '1'}">
                                <i class="Hui-iconfont">&#xe6de;</i>
                            </c:when>
                        </c:choose>


                        </a>
                        <a style="text-decoration:none" class="ml-5" onClick="teachingVideo_edit('课件编辑','teachingVideo-add.html')" href="javascript:;" title="编辑">
                            <i class="Hui-iconfont">&#xe6df;</i>
                        </a>
                        <a style="text-decoration:none" class="ml-5" onClick="teachingVideo_del(this, ${resource.id})" href="javascript:;" title="删除">
                            <i class="Hui-iconfont">&#xe6e2;</i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<!-- TO-DO:将公共模块提出来在公共的js文件，简化操作 -->
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="/static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">

    $('.table-sort').dataTable({
        "aaSorting": [
            [1, "desc"]
        ], //默认第几个排序
        "bStateSave": true, //状态保存
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {
                "orderable": false,
                "aTargets": [0, 5]
            } // 制定列不参与排序
        ]
    });
    /*批量删除*/
    function data_del(){
        var checkedbox = $("[name=box]");
        for(var i=0;i<checkedbox.length;i++){
            if(checkedbox[i].checked){
                checkedbox[i].parents('tr').remove();
            }
        }
    }

    /*录像-添加*/
    function teachingVideo_add(title, url) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }

    /*录像-查看*/
    // function teachingVideo_show(title, url, id) {
    //     var index = layer.open({
    //         type: 2,
    //         title: title,
    //         content: url
    //     });
    //     layer.full(index);
    // }

    /*录像-下架*/
    function teachingVideo_stop(obj, id) {
        layer.confirm('确认要下架吗？', function (index) {
            $(obj).parents("tr").find(".td-manage").prepend(
                '<a style="text-decoration:none" onClick="teachingVideo_start(this,'+id+')" href="javascript:;" title="发布"><i class="Hui-iconfont">&#xe603;</i></a>'
            );
            $.ajax({
                url: '/ResourceServlet.do?type=updateCheck&id='+id+'&status=0',
                method: 'POST',
                success: function (res) {
                    if(res.data){
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已下架</span>');
                        $(obj).remove();
                        layer.msg('已下架!', {
                            icon: 5,
                            time: 1000
                        });
                    }
                    else{

                    }
                }
            })
        });
    }

    /*录像-发布*/
    function teachingVideo_start(obj, id) {
        layer.confirm('确认要发布吗？', function (index) {
            $(obj).parents("tr").find(".td-manage").prepend(
                '<a style="text-decoration:none" onClick="teachingVideo_stop(this,'+id+')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>'
            );
            $.ajax({
                url: '/ResourceServlet.do?type=updateCheck&id='+id+'&status=1',
                method: 'POST',
                success: function (res) {
                    console.log(res)
                    if(res.data){
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已发布</span>');
                        $(obj).remove();
                        layer.msg('已发布!', {
                            icon: 5,
                            time: 1000
                        });
                    }
                    else{

                    }
                }
            })
        });
    }

    /*录像-申请上线*/
    // function teachingVideo_shenqing(obj, id) {
    //     $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">待审核</span>');
    //     $(obj).parents("tr").find(".td-manage").html("");
    //     layer.msg('已提交申请，耐心等待审核!', {
    //         icon: 1,
    //         time: 2000
    //     });
    // }

    /*录像-编辑*/
    function teachingVideo_edit(title, url, id) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }

    /*录像-删除*/
    function teachingVideo_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            $.ajax({
                url: '/ResourceServlet.do?type=delete&id='+id,
                method: 'POST',
                success: function(res){
                    if(res.data){
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!', {
                            icon: 1,
                            time: 1000
                        });
                    }
                    else{

                    }
                }
            })
        });
    }
</script>
</body>

</html>

