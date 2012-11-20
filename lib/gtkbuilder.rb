module Builder

  module Gtk

    ## Defines a new Gtk window
    # @param block A block that will be passed a builder proxy object
    # @return the created window
    def self.new(*args, &block)
      proxy = Builder::Gtk::WindowProxy.new(*args)
      block.call(proxy) if block
      return proxy.widget
    end

  end

end

require 'proxies/window.rb'
require 'proxies/box.rb'

