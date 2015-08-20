module ApplicationHelper

  # Rails embeds a hash to the asset URLs so Retina.js cannot automatically reconcile @2x assets,
  # this method allows us to resolve this issue
  # https://github.com/imulus/retinajs
  def image_tag_with_at2x(name_at_1x, options={})
    name_at_2x = name_at_1x.gsub(%r{\.\w+$}, '@2x\0')
    image_tag(name_at_1x, options.merge("data-at2x" => asset_path(name_at_2x)))
  end

  def pitchhub_devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error-panel" class="panel panel-danger">
      <div class="panel-heading">
        <h3 class="panel-title">#{sentence}</h3>
        <button type="button" class="close"
        data-target="#error-panel"
        data-dismiss="alert" style="margin-top: -15px;">
          <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
        </button>
      </div>
      <div class="panel-body">
        #{messages}
      </div>
    </div>
    HTML

    html.html_safe
  end

end
