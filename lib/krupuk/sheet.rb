# frozen_string_literal: true

module Krupuk
  class Sheet
    def initialize(cards, pdf:, config:, first_sheet:)
      @cards       = cards
      @pdf         = pdf
      @config      = config
      @first_sheet = first_sheet
      @mirror      = BackMirror.new(columns: config.columns)
    end

    def render
      render_fronts_page
      render_backs_page
    end

    private

    def render_fronts_page
      @pdf.start_new_page unless @first_sheet
      @cards.each_with_index do |card, i|
        x, y = front_position(i)
        CutMarks.draw(@pdf, x, y, @config) if @config.cut_marks
        card.draw_front(@pdf, x, y)
      end
    end

    def render_backs_page
      @pdf.start_new_page
      @cards.each_with_index do |card, i|
        x, y = back_position(i)
        card.draw_back(@pdf, x, y)
      end
    end

    def front_position(i)
      col = i % @config.columns
      row = i / @config.columns
      x = col * @config.card_width
      y = @config.margin + (@config.rows - 1 - row) * @config.card_height
      [x, y]
    end

    def back_position(i)
      col = i % @config.columns
      row = i / @config.columns
      x = @mirror.back_x(front_col: col, card_width: @config.card_width)
      y = @config.margin + (@config.rows - 1 - row) * @config.card_height
      [x, y]
    end
  end
end
