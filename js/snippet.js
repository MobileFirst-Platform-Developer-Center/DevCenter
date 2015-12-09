var snippets = $('div.highlight>pre, figure.highlight>pre');

[].forEach.call(snippets, function(snippet) {
    snippet.firstChild.insertAdjacentHTML('beforebegin', '<button class="btn btn-sm clipboard" data-clipboard-snippet><span class="glyphicon glyphicon-copy" aria-hidden="true"></span></button>');
});

var clipboardSnippets = new Clipboard('[data-clipboard-snippet]', {
    target: function(trigger) {
        if(trigger.nextElementSibling.firstChild.tagName == 'TABLE'){
          return $(trigger.nextElementSibling).find('.code pre').get(0);
        }
        else{
          return trigger.nextElementSibling;
      }
    }
});
