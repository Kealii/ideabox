var Ideas = {
    loadAll: function() {
        $.get('/ideas', function(data) {
            var ideasList = $('.ideas');
            $.each(data.ideas, function(_, idea) {
                var newIdea = '<li>'+idea.title+' '+idea.body+'</li>';
                ideasList.append(newIdea);
            });
        });
    },

    create: function(event) {
        var title, body, titleInput, bodyInput;

        titleInput = $(event.target).find('input[name=title]');
        title = titleInput.val();

        bodyInput = $(event.target).find('input[name=body]');
        body = bodyInput.val();

        $.post('/ideas', {title: title, body: body}).success(function(xhr) {
            var newIdea = '<li>'+title+body+'</li>';

            $('.ideas').append(newIdea);

            titleInput.val('');
            bodyInput.val('');
        });
        return false
    }
};

