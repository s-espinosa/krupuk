# frozen_string_literal: true

require "prawn"
require_relative "krupuk/version"
require_relative "krupuk/configuration"
require_relative "krupuk/back_mirror"
require_relative "krupuk/cut_marks"
require_relative "krupuk/sheet"
require_relative "krupuk/layout"

module Krupuk
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.render(pack)
    Layout.new(pack).render
  end
end
