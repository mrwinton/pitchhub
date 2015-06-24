module AssociatedImage
  extend ActiveSupport::Concern

  included do

    before_save :delete_image, if: ->{ self.remove_image == "true"}
    # before_save :delete_image, if: ->{ :remove_image == true && !image_updated_at_changed? }

    # == associated image
    # the face of the pitch card and it's validation
    has_mongoid_attached_file :image
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"],
                                      :size => { :in => 0..1.megabytes }

    # == Temporary attribute
    # used to signal whether we need ro remove the image
    attr_accessor :remove_image

  end

  private

  def delete_image
    self.image.clear
  end


end