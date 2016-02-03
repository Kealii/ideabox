describe('Ideas', function () {
    beforeEach(function() {
        $('body').append('<ul class="ideas"></ul>');
    });

    afterEach(function() {
        $('.ideas').remove();
    });

    describe('loadAll', function () {
        it('fetches the ideas', function () {
            var getSpy = spyOn($, 'get');
            Ideas.loadAll();
            expect(getSpy).toHaveBeenCalledWith('/ideas', jasmine.any(Function))
        });

        it('appends the ideas to the .ideas list', function() {
            var success;
            spyOn($, 'get').and.callFake(function(path, successHandler) {
                success = successHandler;
            });

            Ideas.loadAll();
            success({
                ideas:[{title: 'my title', body: 'my body'}]
            });

            var ideas = $('.ideas').find('li');

            expect(ideas.length).toEqual(1)
            expect($(ideas[0]).text()).toEqual('my title my body')
        });
    })
});