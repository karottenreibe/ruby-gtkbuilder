require 'proxies/layout.rb'

module Builder::Gtk

    ## Proxies a window.
    class WindowProxy

      include LayoutProxy

      ## Creates a new window proxy and a new window.
      def initialize(*args)
        @widget = ::Gtk::Window.new(*args)
      end

      private

      ## Packs the given widget into the window.
      def _pack_widget(widget)
        @widget.add(widget)
      end

    end

end

