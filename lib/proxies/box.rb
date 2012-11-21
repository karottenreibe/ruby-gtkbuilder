require 'proxies/layout.rb'

module Builder::Gtk

  ## Proxies both VBox and HBox
  class BoxProxy

    include LayoutProxy

    ## Creates a new proxy for the given VBox or HBox widget
    # The default packing is @pack_start(widget, false, false, 0)@.
    def initialize(widget)
      @widget = widget
      @data = {
        :position => :start,
        :args => [false, false, 0],
      }
    end

    ## Sets the pack mode to pack_start.
    # The arguments are passed to pack_start for every
    # following widget definition.
    def start(*args, &block)
      return _pack(:start, args, block)
    end

    ## Sets the pack mode to pack_end
    # The arguments are passed to pack_end for every
    # following widget definition.
    def end(*args, &block)
      return _pack(:end, args, block)
    end

    private

    ## Common function for both pack modes.
    # The arguments are passed to the pack function for every
    # following widget definition.
    def _pack(position, args, block)
      @data = {
        :position => position,
        :args => args,
      }
      block.call(self) if block
      return self
    end

    ## Actually packs the given widget using the saved position and arguments.
    def _pack_widget(widget)
      @widget.send("pack_#{@data[:position]}", widget, *@data[:args])
    end

  end

end

