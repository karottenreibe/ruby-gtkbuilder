require 'gtk2'

module Builder::Gtk

  ## Base class for all widgets that can have children
  module LayoutProxy

    ## The widget that is being proxied
    attr_accessor :widget

    ## Handles constructing Gtk widgets
    #
    # Example:
    #
    #   proxy.entry --> Gtk::Entry.new
    #   proxy.vbox(true, 10) --> Gtk::VBox.new(true, 10)
    #   proxy.drawing_area --> Gtk::DrawingArea.new
    #
    # @param name The name of the widget in snake case
    # @param args The arguments to pass to the constructor of
    #     the Gtk widget
    # @param block A block that will be executed with the created widget
    #     or a proxy if one is available.
    def method_missing(name, *args, &block)
      widget = _get_widget(name, args, &block)
      proxy = _get_proxy(name, widget) || widget
      block.call(proxy) if block
      _pack_widget(widget)
      return self
    end

    private

    def _get_widget(name, args, &block)
        class_name = _find_gtk_class(name)
        raise RuntimeError.new("no widget found for name #{name}") unless class_name
        klass = ::Gtk.const_get(class_name)
        return klass.new(*args, &block)
    end

    def _find_gtk_class(name)
      name = name.to_s.gsub("_", "").downcase
      return ::Gtk.constants.find do |constant|
        constant.to_s.downcase == name
      end
    end

    def _get_proxy(name, widget)
      case name.to_s
      when "winodw" then return WindowvboxProxy.new(widget)
      when "vbox" then return BoxProxy.new(widget)
      when "hbox" then return BoxProxy.new(widget)
      else return nil
      end
    end

    def _pack_widget(widget)
      raise RuntimeError.new("cannot pack inside this widget")
    end

  end

end

