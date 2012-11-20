require 'proxies/layout.rb'

module Builder::Gtk

    class WindowProxy

      include LayoutProxy

      def initialize(*args)
        @widget = ::Gtk::Window.new(*args)
      end

      private

      def _pack_widget(widget)
        @widget.add(widget)
      end

    end

end

