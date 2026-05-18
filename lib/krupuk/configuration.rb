# frozen_string_literal: true

module Krupuk
  class Configuration
    attr_accessor :card_width, :card_height, :margin, :columns, :rows,
                  :page_layout, :page_size, :cut_marks

    def initialize
      @card_width  = 180
      @card_height = 252
      @margin      = 18
      @columns     = 4
      @rows        = 2
      @page_layout = :landscape
      @page_size   = "LETTER"
      @cut_marks   = true
    end

    def cards_per_sheet
      columns * rows
    end
  end
end
