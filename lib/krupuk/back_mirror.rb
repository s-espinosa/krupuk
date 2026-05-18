# frozen_string_literal: true

module Krupuk
  class BackMirror
    def initialize(columns:)
      @columns = columns
    end

    def back_x(front_col:, card_width:)
      mirrored_col = @columns - 1 - front_col
      mirrored_col * card_width
    end
  end
end
