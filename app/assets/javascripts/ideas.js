var Ideas = {
    _presentEditButton: function(title, body) {
        return title+' '+body+'<button>Edit</button>';
    },

    _presentIdea: function(id, title, body) {
        return '<li data-id='+id+'>'+Ideas._presentEditButton(title, body)+'</li>';
    },

    showForm: function(event) {
        var li, form;
        li = $(event.target).parent('li');
        form = $('#secretForm');
        form.find('input[type=hidden]').val(li.data('id'));
        li.append(form);
        form.show();
    },

    loadAll: function() {
        $.get('/ideas', function(data) {
            var ideasList = $('.ideas');
            $.each(data.ideas, function(_, idea) {
                ideasList.append(Ideas._presentIdea(idea.id, idea.title, idea.body));
            });
        });
    },

    update: function(event) {
        var title, body, titleInput, bodyInput, id, idInput;

        titleInput = $(event.target).find('input[name=title]');
        title = titleInput.val();

        bodyInput = $(event.target).find('input[name=body]');
        body = bodyInput.val();

        idInput = $(event.target).find('input[name=id]');
        id = idInput.val();

        $.ajax('/ideas/'+id, {
            method: 'PUT',
            data: {title: title, body: body}
            }
        ).success(function(xhr) {
            $('body').append($(event.target).hide());
            $('.ideas').empty();
            Ideas.loadAll();

            titleInput.val('');
            bodyInput.val('');
        });
        return false
    },

    create: function(event) {
        var title, body, titleInput, bodyInput;

        titleInput = $(event.target).find('input[name=title]');
        title = titleInput.val();

        bodyInput = $(event.target).find('input[name=body]');
        body = bodyInput.val();

        $.post('/ideas', {title: title, body: body}).success(function(xhr) {
            $('.ideas').empty();
            Ideas.loadAll();
            titleInput.val('');
            bodyInput.val('');
        });
        return false
    }
};

