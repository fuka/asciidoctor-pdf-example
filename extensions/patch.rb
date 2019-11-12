# patch for Prawn
Prawn::Svg::Font::GENERIC_CSS_FONT_MAPPING.merge!(
  'sans-serif' => 'Sans Serif',
  'serif' => 'Sans Serif'
)

# patch for ditaa
require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include Asciidoctor

Extensions.register do
  preprocessor do
    process do |document, reader|

      new_lines = []
      status = Status::OUTSIDE

      reader.readlines.each do |line|

        if status == Status::OUTSIDE

          status = Status::DETECT if line.start_with? "[ditaa"
          new_lines.push line

        elsif status == Status::INSIDE

          status = Status::OUTSIDE if line.start_with? "...."

          new_line = ""

          line.each_char do |c|
            new_line << c
            new_line << " " if c.bytesize > 1
          end

          new_lines.push new_line

        elsif status == Status::DETECT

          status = Status::INSIDE if line.start_with? "...."
          new_lines.push line
        end
      end

      Reader.new new_lines
    end
  end
end

module Status
  OUTSIDE = 1
  INSIDE  = 2
  DETECT  = 3
end
