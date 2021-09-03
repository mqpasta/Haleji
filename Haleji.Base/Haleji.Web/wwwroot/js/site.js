// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

NOCONTENT = "nocontent";

$(function () {
    var holder = $('#ModalPlaceHolder');
    $('button[data-toggle="ajax-modal"]').click(function (event) {
        var url = $(this).data('url');
        $.get(url).done(function (data) {
            holder.html(data);
            holder.find('.modal').modal('show');
        }).fail(function (jqXHR, textStatus, errorThrown) {
            alert("Error: unable to process the request. Please retry again.");
        })
    })

    holder.on('click', '[data-save=modal]', function (event) {
        event.preventDefault();

        var form = $(this).parents('.modal').find('form');
        var url = form.attr('action');
        var data = form.serialize();

        $.post(url, data).done(function (data, status) {
            var newBody = $('.modal-body', data);
            holder.find('.modal-body').replaceWith(newBody);
            console.log(status);

            // if it's valid then hide modal window            
            if (status == NOCONTENT) {
                holder.find('.modal').modal('hide');
                location.reload();
                return;
            }
            return;

        }).fail(function (jqXHR, textStatus, errorThrown) {
            alert("Error: unable to process the request. Please retry again.");
        })
    })
})