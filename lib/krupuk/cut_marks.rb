# frozen_string_literal: true

module Krupuk
  class CutMarks
    TICK = 18

    def self.draw(pdf, x, y, config)
      w = config.card_width
      h = config.card_height

      pdf.stroke_color("000000")
      pdf.line_width(1)
      pdf.transparent(0.3) do
        pdf.stroke_line([x,     y + h], [x + TICK, y + h])
        pdf.stroke_line([x,     y + h], [x,        y + h - TICK])

        pdf.stroke_line([x + w, y + h], [x + w - TICK, y + h])
        pdf.stroke_line([x + w, y + h], [x + w,        y + h - TICK])

        pdf.stroke_line([x,     y], [x + TICK, y])
        pdf.stroke_line([x,     y], [x,        y + TICK])

        pdf.stroke_line([x + w, y], [x + w - TICK, y])
        pdf.stroke_line([x + w, y], [x + w,        y + TICK])
      end
    end
  end
end
