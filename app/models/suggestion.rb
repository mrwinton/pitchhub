class Suggestion < Comment
  include Mongoid::Enum

  field :content,        type: String
  validates_length_of :content, :minimum => 1, :maximum => PitchPointsHelper.pitch_point_max_length, :allow_blank => true

  def self.split(discourse, n)

    # contains the shares
    discourse_array = []

    # share values
    comment_shares_values = SecretSharingHelper.split_secret(discourse.comment)
    content_shares_values = SecretSharingHelper.split_secret(discourse.content)

    # for n times, add the discourse share to array
    (0..n).each do |counter|

      # duplicate the original discourse
      discourse_share = discourse.dup

      discourse_share.comment = comment_shares_values[counter]
      discourse_share.content = content_shares_values[counter]

      # IMPORTANT: ensure they all have the same ids
      discourse_share.id = id

      # add the share to the array
      discourse_array << discourse_share

    end

    # now completed, return the array of discourses with secure comments
    discourse_array

  end

  def self.combine(discourse_shares)

    # get a share to serve as the base discourse that we will inject the secret_values with
    discourse = discourse_shares.delete_at(0)

    comment_secret_shares = []
    content_secret_shares = []

    discourse_shares.each do |discourse_share|

      comment_secret_shares << discourse_share.comment
      content_secret_shares << discourse_share.content

    end

    # combine the shares
    comment_secret_value = SecretSharingHelper.combine_secret_shares(comment_secret_shares)
    content_secret_value = SecretSharingHelper.combine_secret_shares(content_secret_shares)

    discourse.comment = comment_secret_value
    discourse.content = content_secret_value

    discourse

  end

end
