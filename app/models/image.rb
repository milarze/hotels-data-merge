class Image
  include ActiveModel::Model

  attr_accessor :link, :description

  validate :link, -> { is_a?(String) }
  validate :description, -> { is_a?(String) }

  def initialize(
    link:,
    description:
  )
    @link = link
    @description = description
  end
end
