# frozen_string_literal: true

module Krupuk
  class Layout
    def initialize(pack)
      @pack   = pack
      @config = Krupuk.configuration
      @pdf    = create_pdf
    end

    def render
      @pack.cards
        .each_slice(@config.cards_per_sheet)
        .each_with_index do |sheet_cards, i|
          Sheet.new(sheet_cards, pdf: @pdf, config: @config, first_sheet: i.zero?).render
        end
      @pdf
    end

    private

    def create_pdf
      pdf = Prawn::Document.new(page_layout: @config.page_layout, page_size: @config.page_size)
      pdf.font_families.update(@pack.fonts) if @pack.respond_to?(:fonts) && @pack.fonts
      pdf
    end
  end
end
