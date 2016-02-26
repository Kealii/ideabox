var Ideas = {
    _presentButtons: function(title, body, rating) {
        return 'Title: '+title+'. '+
            '<button class="edit">Edit</button>'+
            '<button class="delete">Delete</button>'+ '<br>'+
            'Body: '+body+'. '+'<br>'+
            'Rating: '+Ideas.convertRating(rating)+' '+'<br>'+
            '<button class="thumbsDown">-</button>'+
            '<button class="thumbsUp">+</button>';
    },

    _presentIdea: function(id, title, body, rating) {
        return '<li data-id='+id+'>'+ Ideas._presentButtons(title, body, rating)+'</li>';
    },

    _render: function(ideas) {
        var $ideas = $('.ideas');
        var $body = $('body');
        var $secretForm = $('#secretForm');
        $body.append($secretForm.hide());
        $ideas.empty();
        $.each(ideas, function(_, idea) {
            $ideas.append(Ideas._presentIdea(idea.id, idea.title, idea.body, idea.rating));
        });
    },

    showForm: function(event) {
        var li = $(event.target).parent('li');
        var $secretForm = $('#secretForm');
        $secretForm.find('input[type=hidden]').val(li.data('id'));
        li.append($secretForm);
        $secretForm.show();
    },

    loadAll: function() {
        $.get('/ideas', function(data) { Ideas._render(data.ideas); });
    },

    create: function(event) {
        var title, body, titleInput, bodyInput;
        var $ideas = $('.ideas');

        titleInput = $(event.target).find('input[name=title]');
        title = titleInput.val();

        bodyInput = $(event.target).find('input[name=body]');
        body = bodyInput.val();

        $.post('/ideas', {title: title, body: body}).success(function() {
            $ideas.empty();
            Ideas.loadAll();
            titleInput.val('');
            bodyInput.val('');
        });
        return false
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
        ).success(function() {
            Ideas.loadAll();
            titleInput.val('');
            bodyInput.val('');
        });
        return false
    },

    delete: function(event) {
        var id = $(event.target).parent('li').data('id');
        $.ajax('/ideas/'+id, { method: 'DELETE' }).success(function() { Ideas.loadAll(); })
    },

    ratingUp: function(event) {
        var id = $(event.target).parent('li').data('id');
        $.ajax('/ideas/'+id, { method: 'PUT', data: { rating: 1 } })
            .success(function() { Ideas.loadAll(); })
    },

    ratingDown: function(event) {
        var id = $(event.target).parent('li').data('id');
        $.ajax('/ideas/'+id, { method: 'PUT', data: { rating: -1 } })
            .success(function() { Ideas.loadAll(); })
    },

    convertRating: function(rating) {
        if(rating == 0) {
            return 'Swill';
        } else if(rating == 1) {
            return 'Plausible';
        } else {
            return 'Genius';
        }
    },

    search: function(event) {
        var query = $(event.target).val();
        $.get('/ideas?q='+query).success(function(data) { Ideas._render(data.ideas) })
    }
};