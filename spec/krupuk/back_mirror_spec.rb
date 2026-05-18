# frozen_string_literal: true

require "spec_helper"

RSpec.describe Krupuk::BackMirror do
  subject(:mirror) { described_class.new(columns: 4) }

  describe "#back_x" do
    it "mirrors column 0 to the rightmost position" do
      expect(mirror.back_x(front_col: 0, card_width: 180)).to eq(540)
    end

    it "mirrors column 3 to the leftmost position" do
      expect(mirror.back_x(front_col: 3, card_width: 180)).to eq(0)
    end

    it "mirrors column 1 to column 2" do
      expect(mirror.back_x(front_col: 1, card_width: 180)).to eq(360)
    end

    it "mirrors column 2 to column 1" do
      expect(mirror.back_x(front_col: 2, card_width: 180)).to eq(180)
    end

    context "with a different column count" do
      subject(:mirror) { described_class.new(columns: 3) }

      it "mirrors correctly for 3 columns" do
        expect(mirror.back_x(front_col: 0, card_width: 100)).to eq(200)
        expect(mirror.back_x(front_col: 1, card_width: 100)).to eq(100)
        expect(mirror.back_x(front_col: 2, card_width: 100)).to eq(0)
      end
    end
  end
end
