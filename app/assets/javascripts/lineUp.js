jQuery(function ($) {
    $('.main table .btn-ok').bind('click', function () {
        var amount = 0;
        $(this).parent().parent().find('td').find('input').each(function () {
            amount = $(this).val();
        });
        $('.main #s-form >input[name = "amount"]').val(amount);
        $('.main #s-form >input[name = "id"]').val($(this).attr('dataValue'));
        $('.main #s-form').submit();
        // $(this).tableTrForm({id:122});
    })
});

$(function () {
    $('#refresh').bind('click', function () {
        var $img = $(this).children('img');
        $img.attr('src', '/captcha?action=captcha&i=' + new Date().getTime())
    });
})

$(function () {
    $('.h-body-form form').submit(function () {
        var reg_email = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$";
        var reg_mobile = "^0?(13|15|18|14)[0-9]{9}$";
        var account_name = $('.h-body-form form .inp1').val();
        var captcha = $('.h-body-form form .inp3').val();
        if (account_name.indexOf("@") > -1) {
            if (!new RegExp(reg_email).test(account_name)) {
                $('.h-body-form .error').html('邮箱地址不正确，请重新输入').show()
                return false;
            }
        } else {
            if (account_name.length != 11) {
                $('.h-body-form .error').html('输入帐号错误,请重新输入').show()
                return false;
            } else if (!new RegExp(reg_mobile).test(account_name)) {
                $('.h-body-form .error').html('手机号码错误,请重新输入').show()
                return false;
            }
        }
        if (captcha.length != 4) {
            $('.h-body-form .error').html('请输入验证码').show()
            return false;
        }
        return true;
    });

})






