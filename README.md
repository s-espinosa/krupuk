# Krupuk

Krupuk generates print-ready PDFs for card games. Given a pack of cards, it lays them out on Letter-size sheets (4 columns × 2 rows by default) with fronts and backs on alternating pages, positioned for duplex printing — backs are mirrored horizontally so they align with their fronts when the sheet is flipped.

## Installation

```ruby
gem 'krupuk', '~> 0.1'
```

## Usage

Call `Krupuk.render` with any object that responds to `cards`. It returns a `Prawn::Document` — call `.render` on it to get the raw PDF bytes.

```ruby
pdf = Krupuk.render(pack)
File.binwrite("cards.pdf", pdf.render)
```

### The pack interface

Your pack object must respond to:

- **`cards`** — returns an enumerable of card objects

Each card object must respond to:

- **`draw_front(pdf, x, y)`** — draws the card front onto `pdf` at the given origin
- **`draw_back(pdf, x, y)`** — draws the card back onto `pdf` at the given origin

The `pdf` argument is a `Prawn::Document`. The `x` and `y` coordinates are in Prawn's point-based coordinate system (origin at bottom-left).

Optionally, the pack may respond to:

- **`fonts`** — returns a hash of font families to register with Prawn before rendering

```ruby
def fonts
  {
    'My Font' => {
      regular: '/path/to/regular.ttf',
      bold:    '/path/to/bold.ttf'
    }
  }
end
```

### Example

```ruby
class MyCard
  def draw_front(pdf, x, y)
    pdf.bounding_box([x, y + 252], width: 180, height: 252) do
      pdf.text "Card Front"
    end
  end

  def draw_back(pdf, x, y)
    pdf.bounding_box([x, y + 252], width: 180, height: 252) do
      pdf.text "Card Back"
    end
  end
end

class MyPack
  def cards
    [MyCard.new, MyCard.new]
  end
end

pdf = Krupuk.render(MyPack.new)
File.binwrite("cards.pdf", pdf.render)
```

## Configuration

Override defaults with `Krupuk.configure`:

```ruby
Krupuk.configure do |config|
  config.card_width  = 180       # points
  config.card_height = 252       # points
  config.margin      = 18        # points
  config.columns     = 4
  config.rows        = 2
  config.page_size   = "LETTER"
  config.page_layout = :landscape
  config.cut_marks   = true
end
```

## Layout

Each sheet produces two PDF pages: a fronts page followed by a backs page. Cards fill left-to-right, top-to-bottom. When more cards are provided than fit on one sheet (`columns × rows`), additional sheets are added automatically.

Cut marks are drawn at each card corner on the fronts page to guide trimming. Set `config.cut_marks = false` to disable them.

Backs are placed right-to-left so that flipping the printed sheet on its vertical axis aligns each back with its front.
