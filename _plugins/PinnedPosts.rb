Jekyll::Hooks.register :site, :pre_render do |site, payload|
  payload['site']['posts'].sort_by!{|p| [p.data['pinned'] ? 1:0, p.date]}.reverse!
end
