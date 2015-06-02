module ApplicationHelper

  # Rails embeds a hash to the asset URLs so Retina.js cannot automatically reconcile @2x assets,
  # this method allows us to resolve this issue
  # https://github.com/imulus/retinajs
  def image_tag_with_at2x(name_at_1x, options={})
    name_at_2x = name_at_1x.gsub(%r{\.\w+$}, '@2x\0')
    image_tag(name_at_1x, options.merge("data-at2x" => asset_path(name_at_2x)))
  end

end
