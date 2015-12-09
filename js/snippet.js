var snippets = $('div.highlight>pre, figure.highlight>pre');

[].forEach.call(snippets, function(snippet) {
    snippet.firstChild.insertAdjacentHTML('beforebegin', '<button data-clipboard-snippet>Copy</button>');
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

clipboardSnippets.on('success', function(e) {
    e.clearSelection();

    showTooltip(e.trigger, 'Copied!');
});

clipboardSnippets.on('error', function(e) {
    showTooltip(e.trigger, fallbackMessage(e.action));
});
