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






