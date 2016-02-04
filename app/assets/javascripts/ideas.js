var Ideas = {
    _presentEditButton: function(title, body, rating) {
        return title+' '+body+' '+Ideas.convertRating(rating)+
            '<button class="thumbsUp">+</button>'+
            '<button class="thumbsDown">-</button>'+
            '<button class="edit">Edit</button>'+
            '<button class="delete">Delete</button>';
    },

    _presentIdea: function(id, title, body, rating) {
        return '<li data-id='+id+'>'+Ideas._presentEditButton(title, body, rating)+'</li>';
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

    ratingUp: function(event) {
      var li = $(event.target).parent('li');
        $.ajax('/ideas/'+li.data('id'),
            {
                method: 'PUT',
                data: { rating: 1 }
            }).success(function() {
                Ideas.loadAll();
            })
    },

    ratingDown: function(event) {
      var li = $(event.target).parent('li');
        $.ajax('/ideas/'+li.data('id'),
            {
                method: 'PUT',
                data: { rating: -1 }
            }).success(function() {
                Ideas.loadAll();
            })
    },

    showForm: function(event) {
        var li, form;
        li = $(event.target).parent('li');
        form = $('#secretForm');
        form.find('input[type=hidden]').val(li.data('id'));
        li.append(form);
        form.show();
    },

    delete: function(event) {
        var li, id;
        li = $(event.target).parent('li');
        id = li.data('id')
        $.ajax('/ideas/'+id, { method: 'DELETE' }).success(function() {
            Ideas.loadAll();
        })
    },

    loadAll: function() {
        $.get('/ideas', function(data) {
            var ideasList = $('.ideas');
            $('body').append($('#secretForm').hide());
            ideasList.empty();
            $.each(data.ideas, function(_, idea) {
                ideasList.append(Ideas._presentIdea(idea.id, idea.title, idea.body, idea.rating));
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
    },


};

