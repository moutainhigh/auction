/**
 * 适用于普通的添加和编辑窗口,注意iframe页面中要定义submitForm和resetForm方法
 */
var html = {
    type : 2,
    shade : 0.3,
    maxmin : true,
    area : [ '100%', '100%' ],
    anim : 1,
    btnAlign : 'r',
    btn : ['取消' ],
    success : function(layero, index) {
    }
};

auctionInfoBatchOff = function(obj){
    var checkStatus = table.checkStatus("search");
    var len = checkStatus.data.length;
    if (len == 0) {
        layer.msg('未选中要操作的行', function() {
        });
    }else {
        layer.confirm('确定要下架吗?', {
            icon: 3,
            title: '警告'
        }, function (index) {

            var arr = [];
            $.each(checkStatus.data, function (i, item) {
                arr[i] = item.id;
            });
            //批量删除
            if (arr.length == 0) {
                layer.msg('未选中要操作的行', function() {
                });
            }else {
                $.get("/auctionProduct/batchOff?ids=" + arr, function (data, status) {
                    if (data.code == '0') {
                        layer.msg("下架成功");
                        if (refreshPage != undefined && refreshPage != null && refreshPage != '') {
                            refreshPage();
                        } else {
                            window.location.reload();
                        }

                    } else {
                        layer.msg(data.msg);
                        if (refreshPage != undefined && refreshPage != null && refreshPage != '') {
                            refreshPage();
                        } else {
                            window.location.reload();
                        }
                    }
                });
            }
        });
    }
}




submitForm = function() {
    $("button[lay-filter='submitBtn']").trigger('click');
}

