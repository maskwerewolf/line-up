(function ($) {
    $.fn.extend({
        tableTrForm: function (options) {
            var defaults = {
                id: 0,
                amount: 0,
                form: 's-form',
                method: 'POST',
                action: '/system'
            }
            var options = $.extend(defaults, options);
            $(this).parent().parent().find('td').find('input').each(function () {
                options.amount = $(this).val();
            });

            $(options.form).submit();

            //return this;
        }
    })
})(jQuery);