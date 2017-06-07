'use strict';

var snippets = $('div.highlighter-rouge>pre.highlight, figure.highlight>pre');

[].forEach.call(snippets, function(snippet) {
    snippet.firstChild.insertAdjacentHTML('beforebegin', '<button class="btn btn-sm clipboard" data-toggle="tooltip" data-placement="bottom" data-trigger="manual" aria-label="Copy to clipboard" data-clipboard-snippet><span class="glyphicon glyphicon-copy" aria-hidden="true"></span></button>');
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

$('.btn.clipboard').on('mouseleave',function(e){
  $(e.currentTarget).tooltip('hide');
});

function showTooltip(elem, msg) {
    elem.setAttribute('title', msg);
    $(elem).tooltip('show');
}

// Simplistic detection, do not use it in production
function fallbackMessage(action) {
    var actionMsg = '';
    var actionKey = (action === 'cut' ? 'X' : 'C');

    if(/iPhone|iPad/i.test(navigator.userAgent)) {
        actionMsg = 'No support :(';
    }
    else if (/Mac/i.test(navigator.userAgent)) {
        actionMsg = 'Press ⌘-' + actionKey + ' to ' + action;
    }
    else {
        actionMsg = 'Press Ctrl-' + actionKey + ' to ' + action;
    }

    return actionMsg;
}
