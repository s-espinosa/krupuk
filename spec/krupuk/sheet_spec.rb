# frozen_string_literal: true

require "spec_helper"

RSpec.describe Krupuk::Sheet do
  let(:config) { Krupuk::Configuration.new }
  let(:pdf)    { instance_double(Prawn::Document).as_null_object }

  def make_card
    instance_double("Card").tap do |card|
      allow(card).to receive(:draw_front)
      allow(card).to receive(:draw_back)
    end
  end

  describe "front positions" do
    it "places the first card at the top-left" do
      card = make_card
      described_class.new([card], pdf: pdf, config: config, first_sheet: true).render
      expect(card).to have_received(:draw_front).with(pdf, 0, 270)
    end

    it "places the second card one card-width to the right" do
      cards = [make_card, make_card]
      described_class.new(cards, pdf: pdf, config: config, first_sheet: true).render
      expect(cards[1]).to have_received(:draw_front).with(pdf, 180, 270)
    end

    it "places the fifth card at the start of the second row" do
      cards = Array.new(5) { make_card }
      described_class.new(cards, pdf: pdf, config: config, first_sheet: true).render
      expect(cards[4]).to have_received(:draw_front).with(pdf, 0, 18)
    end
  end

  describe "back positions" do
    it "mirrors the first card to the rightmost back position" do
      card = make_card
      described_class.new([card], pdf: pdf, config: config, first_sheet: true).render
      expect(card).to have_received(:draw_back).with(pdf, 540, 270)
    end

    it "mirrors the fourth card to the leftmost back position" do
      cards = Array.new(4) { make_card }
      described_class.new(cards, pdf: pdf, config: config, first_sheet: true).render
      expect(cards[3]).to have_received(:draw_back).with(pdf, 0, 270)
    end
  end

  describe "page management" do
    it "calls start_new_page once for the backs page on the first sheet" do
      described_class.new([make_card], pdf: pdf, config: config, first_sheet: true).render
      expect(pdf).to have_received(:start_new_page).once
    end

    it "calls start_new_page twice for subsequent sheets" do
      described_class.new([make_card], pdf: pdf, config: config, first_sheet: false).render
      expect(pdf).to have_received(:start_new_page).twice
    end
  end
end
