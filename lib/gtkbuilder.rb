require 'gtk2'
require 'builder/blankslate.rb'

module Builder

  module Gtk

    module LayoutProxy

      attr_accessor :widget

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
        when "vbox" then return BoxProxy.new(widget)
        when "hbox" then return BoxProxy.new(widget)
        else return nil
        end
      end

      def _pack_widget(widget)
        raise RuntimeError.new("cannot pack inside this widget")
      end

    end

    class Window

      include LayoutProxy

      def initialize(*args)
        @widget = ::Gtk::Window.new(*args)
      end

      private

      def _pack_widget(widget)
        @widget.add(widget)
      end

    end

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
        puts @data
        @widget.send("pack_#{@data[:position]}", widget, *@data[:args])
      end

    end

  end

end

