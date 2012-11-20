require 'proxies/layout.rb'

module Builder::Gtk

  class BoxProxy

    include LayoutProxy

    def initialize(widget)
      @widget = widget
      @data = {
        :position => :start,
        :args => [false, false, 0],
      }
    end

    def start(*args, &block)
      return _pack(:start, args, block)
    end

    def end(*args, &block)
      return _pack(:end, args, block)
    end

    private

    def _pack(position, args, block)
      @data = {
        :position => position,
        :args => args,
      }
      block.call(self) if block
      return self
    end

    def _pack_widget(widget)
      @widget.send("pack_#{@data[:position]}", widget, *@data[:args])
    end

  end

end

