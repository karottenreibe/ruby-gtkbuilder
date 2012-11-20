module Builder

  module Gtk

    def self.new(*args, &block)
      proxy = Builder::Gtk::WindowProxy.new(*args)
      block.call(proxy) if block
      return proxy.widget
    end

  end

end

require 'proxies/window.rb'
require 'proxies/box.rb'

