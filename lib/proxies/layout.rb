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
      if @widget.respond_to?(name)
        return @widget.__send__(name, *args, &block)
      end

      widget = _get_widget(name, args)
      proxy = _get_proxy(name, widget)
      block.call(proxy) if block
      _pack_widget(widget)
      return self
    end

    private

    ## Tries to create a Gtk widget with the given name.
    # All arguments are forwarded to the widget.
    def _get_widget(name, args)
        class_name = _find_gtk_class(name)
        raise RuntimeError.new("no widget found for name `#{name}'") unless class_name
        klass = ::Gtk.const_get(class_name)
        return klass.new(*args)
    end

    ## Tries to find a Gtk widget for the given name
    # @return the found widget class or nil.
    def _find_gtk_class(name)
      name = name.to_s.gsub("_", "").downcase
      return ::Gtk.constants.find do |constant|
        constant.to_s.downcase == name
      end
    end

    ## Creates a proxy for the given widget with the given name.
    # If no proxy can be created, returns the widget itself.
    def _get_proxy(name, widget)
      case name.to_s
      when "window" then return WindowvboxProxy.new(widget)
      when "vbox" then return BoxProxy.new(widget)
      when "hbox" then return BoxProxy.new(widget)
      else return widget
      end
    end

    ## Must be reimplemented by subclasses to actually pack the
    # given widget.
    # Raises an exception by default.
    def _pack_widget(widget)
      raise RuntimeError.new("cannot pack inside this widget. This is a bug in the gtkbuilder implementation")
    end

  end

end

